import { useRef } from "preact/hooks";
import { useAddPhotoToTripMutation } from "../redux/apiStore";
import { useParams } from "react-router-dom";
import { ErrorDisplay } from "./ErrorDisplay";
import "./addImageForm.scss";
import { getText } from "../functions/getText";

export function AddImageForm() {
	const { tripView } = getText();
	const formRef = useRef<HTMLFormElement>(null);
	const inputRef = useRef<HTMLInputElement>(null);
	const { tripId } = useParams();
	const [addPhoto, { isError, error }] = useAddPhotoToTripMutation();

	function onSubmit() {
		if (!formRef.current || !tripId) {
			return console.error("missing form or tripId");
		}

		addPhoto({ tripId, body: new FormData(formRef.current) });
	}

	function onFormClick() {
		if (inputRef.current) {
			inputRef.current.click();
		}
	}

	return (
		<form ref={formRef} class="add-image-form" onClick={onFormClick}>
			<input
				ref={inputRef}
				onChange={onSubmit}
				class="add-image-form__hidden-input"
				type="file"
				name="image"
				accept="image/jpeg"
			/>
			<div class="add-image-form__plus">+</div>
			<div class="add-image-form__message">{tripView.add}</div>
			<ErrorDisplay
				className="add-image-form__error"
				isError={isError}
				error={error}
			/>
		</form>
	);
}
