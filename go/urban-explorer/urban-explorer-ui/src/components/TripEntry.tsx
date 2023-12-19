import { Link } from "react-router-dom";
import { TRIP_TRIPID } from "../routes";
import { Photo, Trip } from "../type";
import { DialogWindow } from "./DialogWindow";
import { useDialog } from "../hooks/useDialog";
import { useDeleteTripMutation } from "../redux/apiStore";
import { replaceURL } from "../functions/replaceURL";
import { TripPhoto } from "./TripPhoto";
import { ReactComponent as NoImage } from "../assets/NoImage.svg";
import "./TripEntry.scss";

type TripEntryProp = {
	entry: Trip;
};

export function TripEntry({ entry }: TripEntryProp) {
	const [deleteTrip] = useDeleteTripMutation();
	const { isOpen, close, open } = useDialog();
	const url = replaceURL(TRIP_TRIPID, { tripId: entry.id });
	let photo: Photo | undefined = undefined;

	function onDelete() {
		deleteTrip(String(entry.id));
	}

	if (entry.photos && entry.photos.length > 0) {
		photo = entry.photos[0];
	}

	return (
		<>
			<li class="trip-entry">
				<Link class="trip-entry__name" to={url}>
					{entry.name}
				</Link>
				<button class="trip-entry__delete-button" onClick={open}>
					Delete
				</button>

				<TripPhoto photo={photo} className="trip-entry__photo" />
				<div class="trip-entry__background">
					<NoImage class="trip-entry__background-icon" />
				</div>
			</li>

			<DialogWindow isOpen={isOpen}>
				<button onClick={onDelete}>Confirm Deletion</button>
				<button onClick={close}>Don't delete</button>
			</DialogWindow>
		</>
	);
}
