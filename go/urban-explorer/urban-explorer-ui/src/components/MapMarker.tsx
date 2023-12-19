import { Photo } from "../type";
import { TripPhoto } from "./TripPhoto";
import "./MapMarker.scss";

type MapMakerProps = {
	photo: Photo;
};

export function MapMaker({ photo }: MapMakerProps) {
	return (
		<div class="map-marker" onClick={() => console.log("aaaa")}>
			<TripPhoto className="map-marker__image" photo={photo} />
		</div>
	);
}
