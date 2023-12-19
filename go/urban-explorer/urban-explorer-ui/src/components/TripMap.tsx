import { Map, Marker, ZoomControl, GeoJson } from "pigeon-maps";
import { useParams } from "react-router-dom";
import { useTripByIdQuery } from "../redux/apiStore";
import { skipToken } from "@reduxjs/toolkit/query";
import { MapMaker } from "./MapMarker";
import { generateMapLines } from "../functions/generateMapLine";
import "./TripMap.scss";

export function TripMap() {
	const { tripId } = useParams();
	const { data } = useTripByIdQuery(tripId ?? skipToken);

	if (!data?.photos || data.photos.length <= 1) {
		return <></>;
	}

	return (
		<div class="trip-map">
			<Map
				defaultCenter={[
					data.photos[0].latitude,
					data.photos[0].longitude,
				]}
				defaultZoom={16}
			>
				<ZoomControl />

				{data.photos.map((photo) => (
					<Marker
						key={photo.id}
						anchor={[photo.latitude, photo.longitude]}
						style={{ zIndex: 1 }}
						offset={[35, 15]} // Magic number for 100px marker
					>
						<MapMaker photo={photo} />
					</Marker>
				))}

				<GeoJson
					data={generateMapLines(data.photos)}
					styleCallback={() => ({
						strokeWidth: "4",
						stroke: "var(--background-tint)",
						strokeLinecap: "round",
					})}
				/>
			</Map>
		</div>
	);
}
