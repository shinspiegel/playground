import { BASE_URL } from "../redux/apiStore";
import { Photo } from "../type";

type TripPhotoProps = {
	photo: Photo;
};

export function TripPhoto({ photo }: TripPhotoProps) {
	return <img src={`${BASE_URL}/photos/${photo.id}`} alt="trip photo" />;
}
