import { useRef, useState } from "preact/hooks";
import { TRIP_NEW_API } from "../constants/apiRoutes";
import { useNavigate } from "react-router-dom";
import { TRIP } from "../routes";

export function NewTripForm() {
	const [err, setErr] = useState<string>();
	const ref = useRef<HTMLFormElement>(null);
	const navigate = useNavigate();

	function onSubmit(e: SubmitEvent) {
		e.preventDefault();
		if (!ref.current) return console.error("missing form");
		fetch(TRIP_NEW_API, {
			credentials: "include",
			method: "POST",
			body: new FormData(ref.current),
		})
			.then((res) => res.json())
			.then((data) => {
				if ("error" in data) throw data;
				navigate(`${TRIP}/${data.id}`);
			})
			.catch((err) => {
				console.error(err);
				setErr(err?.message ?? "unknown error");
			});
	}

	return (
		<form ref={ref} onSubmit={onSubmit}>
			<label>
				Trip Name
				<input type="text" name="name" />
			</label>

			<button type="submit">New Trip</button>

			{err && <span>{err}</span>}
		</form>
	);
}
