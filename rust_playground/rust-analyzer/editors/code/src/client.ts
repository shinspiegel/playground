import * as lc from 'vscode-languageclient/node';
import * as vscode from 'vscode';
import * as ra from '../src/lsp_ext';
import * as Is from 'vscode-languageclient/lib/common/utils/is';
import { DocumentSemanticsTokensSignature, DocumentSemanticsTokensEditsSignature, DocumentRangeSemanticTokensSignature } from 'vscode-languageclient/lib/common/semanticTokens';
import { assert } from './util';
import { WorkspaceEdit } from 'vscode';

export interface Env {
    [name: string]: string;
}

function renderCommand(cmd: ra.CommandLink) {
    return `[${cmd.title}](command:${cmd.command}?${encodeURIComponent(JSON.stringify(cmd.arguments))} '${cmd.tooltip}')`;
}

function renderHoverActions(actions: ra.CommandLinkGroup[]): vscode.MarkdownString {
    const text = actions.map(group =>
        (group.title ? (group.title + " ") : "") + group.commands.map(renderCommand).join(' | ')
    ).join('___');

    const result = new vscode.MarkdownString(text);
    result.isTrusted = true;
    return result;
}

// Workaround for https://github.com/microsoft/vscode-languageserver-node/issues/576
async function semanticHighlightingWorkaround<R, F extends (...args: any[]) => vscode.ProviderResult<R>>(next: F, ...args: Parameters<F>): Promise<R> {
    const res = await next(...args);
    if (res == null) throw new Error('busy');
    return res;
}

export function createClient(serverPath: string, cwd: string, extraEnv: Env): lc.LanguageClient {
    // '.' Is the fallback if no folder is open
    // TODO?: Workspace folders support Uri's (eg: file://test.txt).
    // It might be a good idea to test if the uri points to a file.

    const newEnv = Object.assign({}, process.env);
    Object.assign(newEnv, extraEnv);

    const run: lc.Executable = {
        command: serverPath,
        options: { cwd, env: newEnv },
    };
    const serverOptions: lc.ServerOptions = {
        run,
        debug: run,
    };
    const traceOutputChannel = vscode.window.createOutputChannel(
        'Rust Analyzer Language Server Trace',
    );

    const clientOptions: lc.LanguageClientOptions = {
        documentSelector: [{ scheme: 'file', language: 'rust' }],
        initializationOptions: vscode.workspace.getConfiguration("rust-analyzer"),
        diagnosticCollectionName: "rustc",
        traceOutputChannel,
        middleware: {
            provideDocumentSemanticTokens(document: vscode.TextDocument, token: vscode.CancellationToken, next: DocumentSemanticsTokensSignature): vscode.ProviderResult<vscode.SemanticTokens> {
                return semanticHighlightingWorkaround(next, document, token);
            },
            provideDocumentSemanticTokensEdits(document: vscode.TextDocument, previousResultId: string, token: vscode.CancellationToken, next: DocumentSemanticsTokensEditsSignature): vscode.ProviderResult<vscode.SemanticTokensEdits | vscode.SemanticTokens> {
                return semanticHighlightingWorkaround(next, document, previousResultId, token);
            },
            provideDocumentRangeSemanticTokens(document: vscode.TextDocument, range: vscode.Range, token: vscode.CancellationToken, next: DocumentRangeSemanticTokensSignature): vscode.ProviderResult<vscode.SemanticTokens> {
                return semanticHighlightingWorkaround(next, document, range, token);
            },
            async provideHover(document: vscode.TextDocument, position: vscode.Position, token: vscode.CancellationToken, _next: lc.ProvideHoverSignature) {
                return client.sendRequest(lc.HoverRequest.type, client.code2ProtocolConverter.asTextDocumentPositionParams(document, position), token).then(
                    (result) => {
                        const hover = client.protocol2CodeConverter.asHover(result);
                        if (hover) {
                            const actions = (<any>result).actions;
                            if (actions) {
                                hover.contents.push(renderHoverActions(actions));
                            }
                        }
                        return hover;
                    },
                    (error) => {
                        client.handleFailedRequest(lc.HoverRequest.type, error, null);
                        return Promise.resolve(null);
                    });
            },
            // Using custom handling of CodeActions to support action groups and snippet edits.
            // Note that this means we have to re-implement lazy edit resolving ourselves as well.
            async provideCodeActions(document: vscode.TextDocument, range: vscode.Range, context: vscode.CodeActionContext, token: vscode.CancellationToken, _next: lc.ProvideCodeActionsSignature) {
                const params: lc.CodeActionParams = {
                    textDocument: client.code2ProtocolConverter.asTextDocumentIdentifier(document),
                    range: client.code2ProtocolConverter.asRange(range),
                    context: client.code2ProtocolConverter.asCodeActionContext(context)
                };
                return client.sendRequest(lc.CodeActionRequest.type, params, token).then((values) => {
                    if (values === null) return undefined;
                    const result: (vscode.CodeAction | vscode.Command)[] = [];
                    const groups = new Map<string, { index: number; items: vscode.CodeAction[] }>();
                    for (const item of values) {
                        // In our case we expect to get code edits only from diagnostics
                        if (lc.CodeAction.is(item)) {
                            assert(!item.command, "We don't expect to receive commands in CodeActions");
                            const action = client.protocol2CodeConverter.asCodeAction(item);
                            result.push(action);
                            continue;
                        }
                        assert(isCodeActionWithoutEditsAndCommands(item), "We don't expect edits or commands here");
                        const kind = client.protocol2CodeConverter.asCodeActionKind((item as any).kind);
                        const action = new vscode.CodeAction(item.title, kind);
                        const group = (item as any).group;
                        action.command = {
                            command: "rust-analyzer.resolveCodeAction",
                            title: item.title,
                            arguments: [item],
                        };

                        // Set a dummy edit, so that VS Code doesn't try to resolve this.
                        action.edit = new WorkspaceEdit();

                        if (group) {
                            let entry = groups.get(group);
                            if (!entry) {
                                entry = { index: result.length, items: [] };
                                groups.set(group, entry);
                                result.push(action);
                            }
                            entry.items.push(action);
                        } else {
                            result.push(action);
                        }
                    }
                    for (const [group, { index, items }] of groups) {
                        if (items.length === 1) {
                            result[index] = items[0];
                        } else {
                            const action = new vscode.CodeAction(group);
                            action.kind = items[0].kind;
                            action.command = {
                                command: "rust-analyzer.applyActionGroup",
                                title: "",
                                arguments: [items.map((item) => {
                                    return { label: item.title, arguments: item.command!.arguments![0] };
                                })],
                            };

                            // Set a dummy edit, so that VS Code doesn't try to resolve this.
                            action.edit = new WorkspaceEdit();

                            result[index] = action;
                        }
                    }
                    return result;
                },
                    (_error) => undefined
                );
            }

        }
    };

    const client = new lc.LanguageClient(
        'rust-analyzer',
        'Rust Analyzer Language Server',
        serverOptions,
        clientOptions,
    );

    // To turn on all proposed features use: client.registerProposedFeatures();
    client.registerFeature(new ExperimentalFeatures());

    return client;
}

class ExperimentalFeatures implements lc.StaticFeature {
    fillClientCapabilities(capabilities: lc.ClientCapabilities): void {
        const caps: any = capabilities.experimental ?? {};
        caps.snippetTextEdit = true;
        caps.codeActionGroup = true;
        caps.hoverActions = true;
        caps.statusNotification = true;
        capabilities.experimental = caps;
    }
    initialize(_capabilities: lc.ServerCapabilities<any>, _documentSelector: lc.DocumentSelector | undefined): void {
    }
    dispose(): void {
    }
}

function isCodeActionWithoutEditsAndCommands(value: any): boolean {
    const candidate: lc.CodeAction = value;
    return candidate && Is.string(candidate.title) &&
        (candidate.diagnostics === void 0 || Is.typedArray(candidate.diagnostics, lc.Diagnostic.is)) &&
        (candidate.kind === void 0 || Is.string(candidate.kind)) &&
        (candidate.edit === void 0 && candidate.command === void 0);
}
