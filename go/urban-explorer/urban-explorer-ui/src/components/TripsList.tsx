import { useTripsQuery } from "../redux/apiStore";
import { ErrorDisplay } from "./ErrorDisplay";
import { Loading } from "./Loading";
import { TripEntry } from "./TripEntry";
import "./TripsList.scss";

export function TripsList() {
	const { data, error, isLoading, isError, isFetching } = useTripsQuery();

	if (isLoading || isFetching) {
		return (
			<div class="trip-list">
				<Loading className="trip-list__loading" />
			</div>
		);
	}

	if (isError || !data) {
		return (
			<div class="trip-list">
				<ErrorDisplay isError={isError} error={error} />
			</div>
		);
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
