import { Map, Marker, ZoomControl, GeoJson } from "pigeon-maps";
import { useParams } from "react-router-dom";
import { useTripByIdQuery } from "../redux/apiStore";
import { skipToken } from "@reduxjs/toolkit/query";
import { MapMaker } from "./MapMarker";
import { generateMapLines } from "../functions/generateMapLine";

export function TripMap() {
	const { tripId } = useParams();
	const { data } = useTripByIdQuery(tripId ?? skipToken);

	if (!data?.photos || data.photos.length <= 1) {
		return <></>;
	}

	return (
		<div style={{ height: "400px" }}>
			<Map defaultCenter={[data.photos[0].latitude, data.photos[0].longitude]} defaultZoom={16}>
				<ZoomControl />
				{data.photos.map((p) => (
					<Marker key={p.id} width={50} anchor={[p.latitude, p.longitude]} style={{ zIndex: 1 }}>
						<MapMaker photo={p} />
					</Marker>
				))}

				<GeoJson
					data={generateMapLines(data.photos)}
					styleCallback={() => ({
						strokeWidth: "4",
						stroke: "black",
						strokeLinecap: "round",
					})}
				/>
			</Map>
		</div>
	);
}
