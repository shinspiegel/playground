import { useTripsQuery } from "../redux/apiStore";
import { Loading } from "./Loading";
import { TripEntry } from "./TripEntry";
import "./TripsList.scss";

export function TripsList() {
	const { data, isLoading, isError, isFetching } = useTripsQuery();

	if (isLoading || isFetching) {
		return <Loading />;
	}

	if (isError || !data) {
		return <div>Error</div>;
	}

	return (
		<div class="trip-list">
			<ul class="trip-list__list">
				{data.map((t) => (
					<TripEntry key={t.id} entry={t} />
				))}
			</ul>
		</div>
	);
}
