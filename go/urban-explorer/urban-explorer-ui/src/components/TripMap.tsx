import { Photo } from "../type";
import { Map, Marker, ZoomControl } from "pigeon-maps";
import { TripPhoto } from "./TripPhoto";

type TripMapProps = {
	photos?: Photo[];
};

export function TripMap({ photos }: TripMapProps) {
	if (!photos || photos.length <= 0) {
		return <></>;
	}

	return (
		<div style={{ height: "400px" }}>
			<Map defaultCenter={[photos[0].latitude, photos[0].longitude]} defaultZoom={16}>
				<ZoomControl />
				{photos.map((p) => (
					<Marker width={50} anchor={[p.latitude, p.longitude]} style={{ border: "1px solid black" }}>
						<div style={{ height: "20px", width: "20px", overflow: "hidden" }}>
							<TripPhoto photo={p} />
						</div>
					</Marker>
				))}
			</Map>
		</div>
	);
}
