import { Map, Marker, ZoomControl } from "pigeon-maps";
import { TripPhoto } from "./TripPhoto";
import { useParams } from "react-router-dom";
import { useTripByIdQuery } from "../redux/apiStore";
import { skipToken } from "@reduxjs/toolkit/query";

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
