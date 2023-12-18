import { useDialog } from "../hooks/useDialog";
import { Button } from "./Button";
import { ReactComponent as NewIcon } from "../assets/NewIcon.svg";
import { getText } from "../functions/getText";
import { DialogWindow } from "./DialogWindow";
import { NewTripForm } from "./NewTripForm";
import "./FloatingNewTripButton.scss";

export function FloatingNewTripButton() {
	const { close, isOpen, open } = useDialog();
	const { dashboard, general } = getText();

	return (
		<>
			<Button
				color="primary"
				className="floating-new-trip-button"
				onClick={open}
			>
				<NewIcon className="floating-new-trip-button__icon" />
				{dashboard.newTrip}
			</Button>

			<DialogWindow isOpen={isOpen}>
				<NewTripForm />
				<button onClick={close}>{general.close}</button>
			</DialogWindow>
		</>
	);
}
