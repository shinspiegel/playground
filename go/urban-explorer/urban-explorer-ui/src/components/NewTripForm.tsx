import { useRef } from "preact/hooks";
import { useNavigate } from "react-router-dom";
import { TRIP_TRIPID } from "../routes";
import { useTripNewMutation } from "../redux/apiStore";
import { ErrorDisplay } from "./ErrorDisplay";
import { replaceURL } from "../functions/replaceURL";

export function NewTripForm() {
	const [newTrip, { isError, error }] = useTripNewMutation();
	const ref = useRef<HTMLFormElement>(null);
	const navigate = useNavigate();

	function onSubmit(e: SubmitEvent) {
		e.preventDefault();
		if (!ref.current) return console.error("missing form");
		newTrip(new FormData(ref.current))
			.unwrap()
			.then((r) => navigate(replaceURL(TRIP_TRIPID, { tripId: r.id })));
	}

	return (
		<form ref={ref} onSubmit={onSubmit}>
			<label>
				Trip Name
				<input type="text" name="name" />
			</label>

			<button type="submit">New Trip</button>

			<ErrorDisplay isError={isError} error={error} />
		</form>
	);
}
