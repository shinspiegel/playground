import { PHOTOS_PHOTOID } from "../constants/apiRoutes";
import { useReplace } from "../hooks/useReplace";
import { Photo } from "../type";

type TripPhotoProps = {
	photo: Photo;
};

export function TripPhoto({ photo }: TripPhotoProps) {
	const src = useReplace(PHOTOS_PHOTOID, { photoId: photo.id });

	return <img src={src} alt="trip photo" />;
}
