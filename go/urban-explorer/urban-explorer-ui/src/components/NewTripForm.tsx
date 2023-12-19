import { useRef } from "preact/hooks";
import { useNavigate } from "react-router-dom";
import { TRIP_TRIPID } from "../routes";
import { useTripNewMutation } from "../redux/apiStore";
import { ErrorDisplay } from "./ErrorDisplay";
import { replaceURL } from "../functions/replaceURL";
import { LabeledInput } from "./LabeledInput";
import { Button } from "./Button";
import "./NewTripForm.scss";
import { getText } from "../functions/getText";

export function NewTripForm() {
	const { dashboard, newTrip } = getText();
	const [createNewTrip, { isError, error }] = useTripNewMutation();
	const ref = useRef<HTMLFormElement>(null);
	const navigate = useNavigate();

	function onSubmit(e: SubmitEvent) {
		e.preventDefault();
		if (!ref.current) return console.error("missing form");
		createNewTrip(new FormData(ref.current))
			.unwrap()
			.then((r) => navigate(replaceURL(TRIP_TRIPID, { tripId: r.id })));
	}

	return (
		<form class="new-trip-form" ref={ref} onSubmit={onSubmit}>
			<LabeledInput
				label={newTrip.title}
				type="text"
				name="name"
				placeholder={newTrip.placeholder}
				min={1}
				required
			/>
			<Button color="primary" type="submit">
				{dashboard.newTrip}
			</Button>
			<ErrorDisplay isError={isError} error={error} />
		</form>
	);
}
