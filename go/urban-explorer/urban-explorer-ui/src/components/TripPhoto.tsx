import { BASE_API } from "../redux/apiStore";
import { Photo } from "../type";

type TripPhotoProps = {
	photo: Photo;
};

export function TripPhoto({ photo }: TripPhotoProps) {
	return <img src={`${BASE_API}/photos/${photo.id}`} alt="trip photo" />;
}
