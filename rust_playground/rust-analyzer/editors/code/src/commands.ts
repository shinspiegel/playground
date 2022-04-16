import * as vscode from 'vscode';
import * as lc from 'vscode-languageclient';
import * as ra from './lsp_ext';

import { Ctx, Cmd } from './ctx';
import { applySnippetWorkspaceEdit, applySnippetTextEdits } from './snippets';
import { spawnSync } from 'child_process';
import { RunnableQuickPick, selectRunnable, createTask, createArgs } from './run';
import { AstInspector } from './ast_inspector';
import { isRustDocument, sleep, isRustEditor } from './util';
import { startDebugSession, makeDebugConfig } from './debug';

export * from './ast_inspector';
export * from './run';

export function analyzerStatus(ctx: Ctx): Cmd {
    const tdcp = new class implements vscode.TextDocumentContentProvider {
        readonly uri = vscode.Uri.parse('rust-analyzer-status://status');
        readonly eventEmitter = new vscode.EventEmitter<vscode.Uri>();

        provideTextDocumentContent(_uri: vscode.Uri): vscode.ProviderResult<string> {
            if (!vscode.window.activeTextEditor) return '';

            const params: ra.AnalyzerStatusParams = {};
            const doc = ctx.activeRustEditor?.document;
            if (doc != null) {
                params.textDocument = ctx.client.code2ProtocolConverter.asTextDocumentIdentifier(doc);
            }
            return ctx.client.sendRequest(ra.analyzerStatus, params);
        }

        get onDidChange(): vscode.Event<vscode.Uri> {
            return this.eventEmitter.event;
        }
    }();

    let poller: NodeJS.Timer | undefined = undefined;

    ctx.pushCleanup(
        vscode.workspace.registerTextDocumentContentProvider(
            'rust-analyzer-status',
            tdcp,
        ),
    );

    ctx.pushCleanup({
        dispose() {
            if (poller !== undefined) {
                clearInterval(poller);
            }
        },
    });

    return async () => {
        if (poller === undefined) {
            poller = setInterval(() => tdcp.eventEmitter.fire(tdcp.uri), 1000);
        }
        const document = await vscode.workspace.openTextDocument(tdcp.uri);
        return vscode.window.showTextDocument(document, vscode.ViewColumn.Two, true);
    };
}

export function memoryUsage(ctx: Ctx): Cmd {
    const tdcp = new class implements vscode.TextDocumentContentProvider {
        readonly uri = vscode.Uri.parse('rust-analyzer-memory://memory');
        readonly eventEmitter = new vscode.EventEmitter<vscode.Uri>();

        provideTextDocumentContent(_uri: vscode.Uri): vscode.ProviderResult<string> {
            if (!vscode.window.activeTextEditor) return '';

            return ctx.client.sendRequest(ra.memoryUsage).then((mem: any) => {
                return 'Per-query memory usage:\n' + mem + '\n(note: database has been cleared)';
            });
        }

        get onDidChange(): vscode.Event<vscode.Uri> {
            return this.eventEmitter.event;
        }
    }();

    ctx.pushCleanup(
        vscode.workspace.registerTextDocumentContentProvider(
            'rust-analyzer-memory',
            tdcp,
        ),
    );

    return async () => {
        tdcp.eventEmitter.fire(tdcp.uri);
        const document = await vscode.workspace.openTextDocument(tdcp.uri);
        return vscode.window.showTextDocument(document, vscode.ViewColumn.Two, true);
    };
}

export function matchingBrace(ctx: Ctx): Cmd {
    return async () => {
        const editor = ctx.activeRustEditor;
        const client = ctx.client;
        if (!editor || !client) return;

        const response = await client.sendRequest(ra.matchingBrace, {
            textDocument: ctx.client.code2ProtocolConverter.asTextDocumentIdentifier(editor.document),
            positions: editor.selections.map(s =>
                client.code2ProtocolConverter.asPosition(s.active),
            ),
        });
        editor.selections = editor.selections.map((sel, idx) => {
            const active = client.protocol2CodeConverter.asPosition(
                response[idx],
            );
            const anchor = sel.isEmpty ? active : sel.anchor;
            return new vscode.Selection(anchor, active);
        });
        editor.revealRange(editor.selection);
    };
}

export function joinLines(ctx: Ctx): Cmd {
    return async () => {
        const editor = ctx.activeRustEditor;
        const client = ctx.client;
        if (!editor || !client) return;

        const items: lc.TextEdit[] = await client.sendRequest(ra.joinLines, {
            ranges: editor.selections.map((it) => client.code2ProtocolConverter.asRange(it)),
            textDocument: ctx.client.code2ProtocolConverter.asTextDocumentIdentifier(editor.document),
        });
        await editor.edit((builder) => {
            client.protocol2CodeConverter.asTextEdits(items).forEach((edit: any) => {
                builder.replace(edit.range, edit.newText);
            });
        });
    };
}

export function onEnter(ctx: Ctx): Cmd {
    async function handleKeypress() {
        const editor = ctx.activeRustEditor;
        const client = ctx.client;

        if (!editor || !client) return false;

        const lcEdits = await client.sendRequest(ra.onEnter, {
            textDocument: ctx.client.code2ProtocolConverter.asTextDocumentIdentifier(editor.document),
            position: client.code2ProtocolConverter.asPosition(
                editor.selection.active,
            ),
        }).catch((_error: any) => {
            // client.handleFailedRequest(OnEnterRequest.type, error, null);
            return null;
        });
        if (!lcEdits) return false;

        const edits = client.protocol2CodeConverter.asTextEdits(lcEdits);
        await applySnippetTextEdits(editor, edits);
        return true;
    }

    return async () => {
        if (await handleKeypress()) return;

        await vscode.commands.executeCommand('default:type', { text: '\n' });
    };
}

export function parentModule(ctx: Ctx): Cmd {
    return async () => {
        const editor = ctx.activeRustEditor;
        const client = ctx.client;
        if (!editor || !client) return;

        const response = await client.sendRequest(ra.parentModule, {
            textDocument: ctx.client.code2ProtocolConverter.asTextDocumentIdentifier(editor.document),
            position: client.code2ProtocolConverter.asPosition(
                editor.selection.active,
            ),
        });
        const loc = response[0];
        if (!loc) return;

        const uri = client.protocol2CodeConverter.asUri(loc.targetUri);
        const range = client.protocol2CodeConverter.asRange(loc.targetRange);

        const doc = await vscode.workspace.openTextDocument(uri);
        const e = await vscode.window.showTextDocument(doc);
        e.selection = new vscode.Selection(range.start, range.start);
        e.revealRange(range, vscode.TextEditorRevealType.InCenter);
    };
}

export function openCargoToml(ctx: Ctx): Cmd {
    return async () => {
        const editor = ctx.activeRustEditor;
        const client = ctx.client;
        if (!editor || !client) return;

        const response = await client.sendRequest(ra.openCargoToml, {
            textDocument: ctx.client.code2ProtocolConverter.asTextDocumentIdentifier(editor.document),
        });
        if (!response) return;

        const uri = client.protocol2CodeConverter.asUri(response.uri);
        const range = client.protocol2CodeConverter.asRange(response.range);

        const doc = await vscode.workspace.openTextDocument(uri);
        const e = await vscode.window.showTextDocument(doc);
        e.selection = new vscode.Selection(range.start, range.start);
        e.revealRange(range, vscode.TextEditorRevealType.InCenter);
    };
}

export function ssr(ctx: Ctx): Cmd {
    return async () => {
        const editor = vscode.window.activeTextEditor;
        const client = ctx.client;
        if (!editor || !client) return;

        const position = editor.selection.active;
        const selections = editor.selections;
        const textDocument = ctx.client.code2ProtocolConverter.asTextDocumentIdentifier(editor.document);

        const options: vscode.InputBoxOptions = {
            value: "() ==>> ()",
            prompt: "Enter request, for example 'Foo($a) ==>> Foo::new($a)' ",
            validateInput: async (x: string) => {
                try {
                    await client.sendRequest(ra.ssr, {
                        query: x, parseOnly: true, textDocument, position, selections,
                    });
                } catch (e) {
                    return e.toString();
                }
                return null;
            }
        };
        const request = await vscode.window.showInputBox(options);
        if (!request) return;

        await vscode.window.withProgress({
            location: vscode.ProgressLocation.Notification,
            title: "Structured search replace in progress...",
            cancellable: false,
        }, async (_progress, _token) => {
            const edit = await client.sendRequest(ra.ssr, {
                query: request, parseOnly: false, textDocument, position, selections,
            });

            await vscode.workspace.applyEdit(client.protocol2CodeConverter.asWorkspaceEdit(edit));
        });
    };
}

export function serverVersion(ctx: Ctx): Cmd {
    return async () => {
        const { stdout } = spawnSync(ctx.serverPath, ["--version"], { encoding: "utf8" });
        const commitHash = stdout.slice(`rust-analyzer `.length).trim();
        const { releaseTag } = ctx.config.package;

        void vscode.window.showInformationMessage(
            `rust-analyzer version: ${releaseTag ?? "unreleased"} (${commitHash})`
        );
    };
}

export function toggleInlayHints(ctx: Ctx): Cmd {
    return async () => {
        await vscode
            .workspace
            .getConfiguration(`${ctx.config.rootSection}.inlayHints`)
            .update('enable', !ctx.config.inlayHints.enable, vscode.ConfigurationTarget.Workspace);
    };
}

// Opens the virtual file that will show the syntax tree
//
// The contents of the file come from the `TextDocumentContentProvider`
export function syntaxTree(ctx: Ctx): Cmd {
    const tdcp = new class implements vscode.TextDocumentContentProvider {
        readonly uri = vscode.Uri.parse('rust-analyzer://syntaxtree/tree.rast');
        readonly eventEmitter = new vscode.EventEmitter<vscode.Uri>();
        constructor() {
            vscode.workspace.onDidChangeTextDocument(this.onDidChangeTextDocument, this, ctx.subscriptions);
            vscode.window.onDidChangeActiveTextEditor(this.onDidChangeActiveTextEditor, this, ctx.subscriptions);
        }

        private onDidChangeTextDocument(event: vscode.TextDocumentChangeEvent) {
            if (isRustDocument(event.document)) {
                // We need to order this after language server updates, but there's no API for that.
                // Hence, good old sleep().
                void sleep(10).then(() => this.eventEmitter.fire(this.uri));
            }
        }
        private onDidChangeActiveTextEditor(editor: vscode.TextEditor | undefined) {
            if (editor && isRustEditor(editor)) {
                this.eventEmitter.fire(this.uri);
            }
        }

        provideTextDocumentContent(uri: vscode.Uri, ct: vscode.CancellationToken): vscode.ProviderResult<string> {
            const rustEditor = ctx.activeRustEditor;
            if (!rustEditor) return '';

            // When the range based query is enabled we take the range of the selection
            const range = uri.query === 'range=true' && !rustEditor.selection.isEmpty
                ? ctx.client.code2ProtocolConverter.asRange(rustEditor.selection)
                : null;

            const params = { textDocument: { uri: rustEditor.document.uri.toString() }, range, };
            return ctx.client.sendRequest(ra.syntaxTree, params, ct);
        }

        get onDidChange(): vscode.Event<vscode.Uri> {
            return this.eventEmitter.event;
        }
    };

    void new AstInspector(ctx);

    ctx.pushCleanup(vscode.workspace.registerTextDocumentContentProvider('rust-analyzer', tdcp));
    ctx.pushCleanup(vscode.languages.setLanguageConfiguration("ra_syntax_tree", {
        brackets: [["[", ")"]],
    }));

    return async () => {
        const editor = vscode.window.activeTextEditor;
        const rangeEnabled = !!editor && !editor.selection.isEmpty;

        const uri = rangeEnabled
            ? vscode.Uri.parse(`${tdcp.uri.toString()}?range=true`)
            : tdcp.uri;

        const document = await vscode.workspace.openTextDocument(uri);

        tdcp.eventEmitter.fire(uri);

        void await vscode.window.showTextDocument(document, {
            viewColumn: vscode.ViewColumn.Two,
            preserveFocus: true
        });
    };
}

// Opens the virtual file that will show the HIR of the function containing the cursor position
//
// The contents of the file come from the `TextDocumentContentProvider`
export function viewHir(ctx: Ctx): Cmd {
    const tdcp = new class implements vscode.TextDocumentContentProvider {
        readonly uri = vscode.Uri.parse('rust-analyzer://viewHir/hir.txt');
        readonly eventEmitter = new vscode.EventEmitter<vscode.Uri>();
        constructor() {
            vscode.workspace.onDidChangeTextDocument(this.onDidChangeTextDocument, this, ctx.subscriptions);
            vscode.window.onDidChangeActiveTextEditor(this.onDidChangeActiveTextEditor, this, ctx.subscriptions);
        }

        private onDidChangeTextDocument(event: vscode.TextDocumentChangeEvent) {
            if (isRustDocument(event.document)) {
                // We need to order this after language server updates, but there's no API for that.
                // Hence, good old sleep().
                void sleep(10).then(() => this.eventEmitter.fire(this.uri));
            }
        }
        private onDidChangeActiveTextEditor(editor: vscode.TextEditor | undefined) {
            if (editor && isRustEditor(editor)) {
                this.eventEmitter.fire(this.uri);
            }
        }

        provideTextDocumentContent(_uri: vscode.Uri, ct: vscode.CancellationToken): vscode.ProviderResult<string> {
            const rustEditor = ctx.activeRustEditor;
            const client = ctx.client;
            if (!rustEditor || !client) return '';

            const params = {
                textDocument: client.code2ProtocolConverter.asTextDocumentIdentifier(rustEditor.document),
                position: client.code2ProtocolConverter.asPosition(
                    rustEditor.selection.active,
                ),
            };
            return client.sendRequest(ra.viewHir, params, ct);
        }

        get onDidChange(): vscode.Event<vscode.Uri> {
            return this.eventEmitter.event;
        }
    };

    ctx.pushCleanup(vscode.workspace.registerTextDocumentContentProvider('rust-analyzer', tdcp));

    return async () => {
        const document = await vscode.workspace.openTextDocument(tdcp.uri);
        tdcp.eventEmitter.fire(tdcp.uri);
        void await vscode.window.showTextDocument(document, {
            viewColumn: vscode.ViewColumn.Two,
            preserveFocus: true
        });
    };
}

// Opens the virtual file that will show the syntax tree
//
// The contents of the file come from the `TextDocumentContentProvider`
export function expandMacro(ctx: Ctx): Cmd {
    function codeFormat(expanded: ra.ExpandedMacro): string {
        let result = `// Recursive expansion of ${expanded.name}! macro\n`;
        result += '// ' + '='.repeat(result.length - 3);
        result += '\n\n';
        result += expanded.expansion;

        return result;
    }

    const tdcp = new class implements vscode.TextDocumentContentProvider {
        uri = vscode.Uri.parse('rust-analyzer://expandMacro/[EXPANSION].rs');
        eventEmitter = new vscode.EventEmitter<vscode.Uri>();
        async provideTextDocumentContent(_uri: vscode.Uri): Promise<string> {
            const editor = vscode.window.activeTextEditor;
            const client = ctx.client;
            if (!editor || !client) return '';

            const position = editor.selection.active;

            const expanded = await client.sendRequest(ra.expandMacro, {
                textDocument: ctx.client.code2ProtocolConverter.asTextDocumentIdentifier(editor.document),
                position,
            });

            if (expanded == null) return 'Not available';

            return codeFormat(expanded);
        }

        get onDidChange(): vscode.Event<vscode.Uri> {
            return this.eventEmitter.event;
        }
    }();

    ctx.pushCleanup(
        vscode.workspace.registerTextDocumentContentProvider(
            'rust-analyzer',
            tdcp,
        ),
    );

    return async () => {
        const document = await vscode.workspace.openTextDocument(tdcp.uri);
        tdcp.eventEmitter.fire(tdcp.uri);
        return vscode.window.showTextDocument(
            document,
            vscode.ViewColumn.Two,
            true,
        );
    };
}

export function reloadWorkspace(ctx: Ctx): Cmd {
    return async () => ctx.client.sendRequest(ra.reloadWorkspace);
}

export function showReferences(ctx: Ctx): Cmd {
    return async (uri: string, position: lc.Position, locations: lc.Location[]) => {
        const client = ctx.client;
        if (client) {
            await vscode.commands.executeCommand(
                'editor.action.showReferences',
                vscode.Uri.parse(uri),
                client.protocol2CodeConverter.asPosition(position),
                locations.map(client.protocol2CodeConverter.asLocation),
            );
        }
    };
}

export function applyActionGroup(_ctx: Ctx): Cmd {
    return async (actions: { label: string; arguments: lc.CodeAction }[]) => {
        const selectedAction = await vscode.window.showQuickPick(actions);
        if (!selectedAction) return;
        await vscode.commands.executeCommand(
            'rust-analyzer.resolveCodeAction',
            selectedAction.arguments,
        );
    };
}

export function gotoLocation(ctx: Ctx): Cmd {
    return async (locationLink: lc.LocationLink) => {
        const client = ctx.client;
        if (client) {
            const uri = client.protocol2CodeConverter.asUri(locationLink.targetUri);
            let range = client.protocol2CodeConverter.asRange(locationLink.targetSelectionRange);
            // collapse the range to a cursor position
            range = range.with({ end: range.start });

            await vscode.window.showTextDocument(uri, { selection: range });
        }
    };
}

export function openDocs(ctx: Ctx): Cmd {
    return async () => {

        const client = ctx.client;
        const editor = vscode.window.activeTextEditor;
        if (!editor || !client) {
            return;
        };

        const position = editor.selection.active;
        const textDocument = { uri: editor.document.uri.toString() };

        const doclink = await client.sendRequest(ra.openDocs, { position, textDocument });

        if (doclink != null) {
            await vscode.commands.executeCommand("vscode.open", vscode.Uri.parse(doclink));
        }
    };

}

export function resolveCodeAction(ctx: Ctx): Cmd {
    const client = ctx.client;
    return async (params: lc.CodeAction) => {
        params.command = undefined;
        const item = await client.sendRequest(lc.CodeActionResolveRequest.type, params);
        if (!item.edit) {
            return;
        }
        const itemEdit = item.edit;
        const edit = client.protocol2CodeConverter.asWorkspaceEdit(itemEdit);
        // filter out all text edits and recreate the WorkspaceEdit without them so we can apply
        // snippet edits on our own
        const lcFileSystemEdit = { ...itemEdit, documentChanges: itemEdit.documentChanges?.filter(change => "kind" in change) };
        const fileSystemEdit = client.protocol2CodeConverter.asWorkspaceEdit(lcFileSystemEdit);
        await vscode.workspace.applyEdit(fileSystemEdit);
        await applySnippetWorkspaceEdit(edit);
    };
}

export function applySnippetWorkspaceEditCommand(_ctx: Ctx): Cmd {
    return async (edit: vscode.WorkspaceEdit) => {
        await applySnippetWorkspaceEdit(edit);
    };
}

export function run(ctx: Ctx): Cmd {
    let prevRunnable: RunnableQuickPick | undefined;

    return async () => {
        const item = await selectRunnable(ctx, prevRunnable);
        if (!item) return;

        item.detail = 'rerun';
        prevRunnable = item;
        const task = await createTask(item.runnable, ctx.config);
        return await vscode.tasks.executeTask(task);
    };
}

export function runSingle(ctx: Ctx): Cmd {
    return async (runnable: ra.Runnable) => {
        const editor = ctx.activeRustEditor;
        if (!editor) return;

        const task = await createTask(runnable, ctx.config);
        task.group = vscode.TaskGroup.Build;
        task.presentationOptions = {
            reveal: vscode.TaskRevealKind.Always,
            panel: vscode.TaskPanelKind.Dedicated,
            clear: true,
        };

        return vscode.tasks.executeTask(task);
    };
}

export function copyRunCommandLine(ctx: Ctx) {
    let prevRunnable: RunnableQuickPick | undefined;
    return async () => {
        const item = await selectRunnable(ctx, prevRunnable);
        if (!item) return;
        const args = createArgs(item.runnable);
        const commandLine = ["cargo", ...args].join(" ");
        await vscode.env.clipboard.writeText(commandLine);
        await vscode.window.showInformationMessage("Cargo invocation copied to the clipboard.");
    };
}

export function debug(ctx: Ctx): Cmd {
    let prevDebuggee: RunnableQuickPick | undefined;

    return async () => {
        const item = await selectRunnable(ctx, prevDebuggee, true);
        if (!item) return;

        item.detail = 'restart';
        prevDebuggee = item;
        return await startDebugSession(ctx, item.runnable);
    };
}

export function debugSingle(ctx: Ctx): Cmd {
    return async (config: ra.Runnable) => {
        await startDebugSession(ctx, config);
    };
}

export function newDebugConfig(ctx: Ctx): Cmd {
    return async () => {
        const item = await selectRunnable(ctx, undefined, true, false);
        if (!item) return;

        await makeDebugConfig(ctx, item.runnable);
    };
}
