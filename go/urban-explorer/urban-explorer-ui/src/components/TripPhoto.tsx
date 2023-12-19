import { BASE_URL } from "../redux/apiStore";
import { Photo, WithClassName } from "../type";

type TripPhotoProps = {
	photo?: Photo;
} & WithClassName;

export function TripPhoto({ photo, className }: TripPhotoProps) {
	if (!photo) {
		return <></>;
	}

	return (
		<img
			class={className}
			src={`${BASE_URL}/assets/photos/${photo.id}`}
			alt="trip photo"
		/>
	);
}
