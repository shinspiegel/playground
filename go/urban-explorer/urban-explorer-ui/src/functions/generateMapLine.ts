import { Photo } from "../type";

export function generateMapLines(photos: Photo[]) {
	return {
		type: "FeatureCollection",
		features: [
			{
				type: "Feature",
				geometry: {
					type: "LineString",
					coordinates: [...photos.map((p) => [p.longitude, p.latitude])],
				},
			},
		],
	};
}
