import { Link } from "react-router-dom";
import { useReplace } from "../hooks/useReplace";
import { TRIP_TRIPID } from "../routes";
import { Trip } from "../type";
import { DialogWindow } from "./DialogWindow";
import { useDialog } from "../hooks/useDialog";
import { useDeleteTripMutation } from "../redux/apiStore";

type TripEntryProp = {
	entry: Trip;
};

export function TripEntry({ entry }: TripEntryProp) {
	const [deleteTrip] = useDeleteTripMutation();
	const { isOpen, close, open } = useDialog();
	const url = useReplace(TRIP_TRIPID, { tripId: entry.id });

	function onDelete() {
		deleteTrip(String(entry.id));
	}

	return (
		<>
			<Link to={url}>{entry.name}</Link>
			<button onClick={open}>Delete</button>

			<DialogWindow isOpen={isOpen}>
				<button onClick={onDelete}>Confirm Deletion</button>
				<button onClick={close}>Don't delete</button>
			</DialogWindow>
		</>
	);
}
