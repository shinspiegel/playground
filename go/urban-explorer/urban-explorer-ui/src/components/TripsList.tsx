import { TRIP_API } from "../constants/apiRoutes";
import { useFetch } from "../hooks/useFetch";
import { Trip } from "../type";
import { Loading } from "./Loading";
import { TripEntry } from "./TripEntry";

export function TripsList() {
	const { data, error, loading } = useFetch<Trip[]>(TRIP_API, { credentials: "include" });

	if (loading) {
		return <Loading />;
	}

	if (error || !data) {
		return <div>Error</div>;
	}

	return (
		<div>
			Trips
			<ul>
				{data.map((t) => (
					<TripEntry key={t.id} entry={t} />
				))}
			</ul>
		</div>
	);
}
