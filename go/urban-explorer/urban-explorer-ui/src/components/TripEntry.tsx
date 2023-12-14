import { Link } from "react-router-dom";
import { useReplace } from "../hooks/useReplace";
import { TRIP_TRIPID } from "../routes";
import { Trip } from "../type";

type TripEntryProp = {
	entry: Trip;
};

export function TripEntry({ entry }: TripEntryProp) {
	const url = useReplace(TRIP_TRIPID, { tripId: entry.id });
	return (
		<li>
			<Link to={url}>{entry.name}</Link>
		</li>
	);
}
