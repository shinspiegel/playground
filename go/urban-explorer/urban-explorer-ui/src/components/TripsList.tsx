import { useTripsQuery } from "../redux/apiStore";
import { Loading } from "./Loading";
import { TripEntry } from "./TripEntry";

export function TripsList() {
	const { data, isLoading, isError, isFetching } = useTripsQuery();

	if (isLoading || isFetching) {
		return <Loading />;
	}

	if (isError || !data) {
		return <div>Error</div>;
	}

	return (
		<div>
			Trips
			<ul>
				{data.map((t) => (
					<li>
						<TripEntry key={t.id} entry={t} />
					</li>
				))}
			</ul>
		</div>
	);
}
