import { useState } from "preact/hooks";

type UseDialogOpt = {
	initialState?: boolean;
};

export function useDialog({ initialState = false }: UseDialogOpt = {}) {
	const [isOpen, setIsOpen] = useState(initialState);

	function open() {
		setIsOpen(true);
	}

	function close() {
		setIsOpen(false);
	}

	return {
		isOpen,
		open,
		close,
	};
}
