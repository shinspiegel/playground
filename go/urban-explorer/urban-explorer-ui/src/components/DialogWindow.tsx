import { PropsWithChildren } from "preact/compat";

type ConfirmModalProps = {
	isOpen?: boolean;
	onClose?: () => void;
} & PropsWithChildren;

export function DialogWindow({ isOpen, onClose, children }: ConfirmModalProps) {
	return (
		<dialog open={isOpen}>
			<div>{children}</div>
			<button onClick={onClose}>Close</button>
		</dialog>
	);
}
