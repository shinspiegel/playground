import { useRef, useState } from "preact/hooks";
import { TRIP_TRIPID_PHOTO_ADD } from "../constants/apiRoutes";
import { useReplace } from "../hooks/useReplace";

type AddImageFormProps = {
	tripId: string;
	onAddImage?: (data: any) => void;
};

export function AddImageForm({ tripId, onAddImage = () => {} }: AddImageFormProps) {
	const [err, setErr] = useState<string>();
	const url = useReplace(TRIP_TRIPID_PHOTO_ADD, { tripId });
	const ref = useRef<HTMLFormElement>(null);

	function onSubmit(e: SubmitEvent) {
		e.preventDefault();
		if (!ref.current) return console.error("missing form");

		fetch(url, { credentials: "include", method: "POST", body: new FormData(ref.current) })
			.then((res) => res.json())
			.then((data) => {
				if ("error" in data) throw data;
				onAddImage(data);
				ref.current?.reset();
			})
			.catch((err) => {
				console.error(err);
				setErr(err?.message ?? "unknown error");
			});
	}

	return (
		<form ref={ref} onSubmit={onSubmit}>
			<label>
				Add Image
				<input type="file" name="image" accept="image/jpeg" />
			</label>
			<button type="submit">Add Image</button>

			{err && <span>{err}</span>}
		</form>
	);
}
