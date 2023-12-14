import { PHOTOS_PHOTOID } from "../constants/apiRoutes";
import { useReplace } from "../hooks/useReplace";
import { Photo } from "../type";

type PhotoEntryProps = {
	item: Photo;
};

export function PhotoEntry({ item }: PhotoEntryProps) {
	const src = useReplace(PHOTOS_PHOTOID, { photoId: item.id });

	return (
		<div>
			<div>{item.id}</div>
			<div>
				{item.latitude} - {item.longitude}
			</div>
			<div>{item.timestamp}</div>
			<img src={src} />
		</div>
	);
}
