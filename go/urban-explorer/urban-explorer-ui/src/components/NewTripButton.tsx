import { useDialog } from "../hooks/useDialog";
import { getText } from "../functions/getText";
import { DialogWindow } from "./DialogWindow";
import { NewTripForm } from "./NewTripForm";
import { Button } from "./Button";
import "./NewTripButton.scss";

export function NewTripButton() {
	const { close, isOpen, open } = useDialog();
	const { dashboard, general } = getText();

	return (
		<>
			<button className="floating-new-trip-button" onClick={open}>
				{dashboard.newTrip}
			</button>

			<DialogWindow
				className="floating-new-trip-button__dialog"
				isOpen={isOpen}
			>
				<NewTripForm />
				<Button onClick={close}>{general.close}</Button>
			</DialogWindow>
		</>
	);
}
