import { PropsWithChildren } from "preact/compat";
import { WithClassName } from "../type";
import "./DialogWindow.scss";

type ConfirmModalProps = {
	isOpen?: boolean;
} & PropsWithChildren &
	WithClassName;

export function DialogWindow({
	className,
	isOpen,
	children,
}: ConfirmModalProps) {
	const names = ["dialog-window"];
	if (className) names.push(className);

	return (
		<>
			<dialog class={names.join(" ")} open={isOpen}>
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
