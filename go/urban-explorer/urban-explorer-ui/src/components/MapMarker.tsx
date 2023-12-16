import { Photo } from "../type";
import { TripPhoto } from "./TripPhoto";

type MapMakerProps = {
	photo: Photo;
};

export function MapMaker({ photo }: MapMakerProps) {
	return (
		<div
			style={{
				border: "2px solid black",
				height: "100px",
				width: "100px",
				overflow: "hidden",
				borderRadius: "999rem",
			}}
		>
			<TripPhoto photo={photo} />
		</div>
	);
}
