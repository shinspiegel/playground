import { PropsWithChildren } from "preact/compat";
import "./DialogWindow.scss";

type ConfirmModalProps = {
	isOpen?: boolean;
} & PropsWithChildren;

export function DialogWindow({ isOpen, children }: ConfirmModalProps) {
	return (
		<>
			<dialog class="dialog-window" open={isOpen}>
				{children}
			</dialog>
			<div
				class={`dialog-window__background ${
					isOpen ? "dialog-window__background--open" : ""
				}`}
			/>
		</>
	);
}
