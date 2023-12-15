import { useRef } from "preact/hooks";
import { useAddPhotoToTripMutation } from "../redux/apiStore";
import { useParams } from "react-router-dom";
import { ErrorDisplay } from "./ErrorDisplay";

export function AddImageForm() {
	const { tripId } = useParams();
	const ref = useRef<HTMLFormElement>(null);
	const [addPhoto, { isError, error }] = useAddPhotoToTripMutation();

	function onSubmit(e: SubmitEvent) {
		e.preventDefault();
		if (!ref.current || !tripId) return console.error("missing form or tripId");
		addPhoto({ tripId, body: new FormData(ref.current) });
	}

	return (
		<form ref={ref} onSubmit={onSubmit}>
			<label>
				Add Image
				<input type="file" name="image" accept="image/jpeg" />
			</label>
			<button type="submit">Add Image</button>

			<ErrorDisplay isError={isError} error={error} />
		</form>
	);
}
