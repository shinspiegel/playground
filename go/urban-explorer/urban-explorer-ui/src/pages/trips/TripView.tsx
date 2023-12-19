import { useParams } from "react-router-dom";
import { PrivatePage } from "../../layout/PrivatePage";
import { AddImageForm } from "../../components/AddImageForm";
import { PhotosList } from "../../components/PhotosList";
import { TripMap } from "../../components/TripMap";
import { useTripByIdQuery } from "../../redux/apiStore";
import { skipToken } from "@reduxjs/toolkit/query";
import { Loading } from "../../components/Loading";
import { ErrorDisplay } from "../../components/ErrorDisplay";
import { NavListDashboard } from "../../components/NavListDashboard";
import "./TripView.scss";

export function TripId() {
	const { tripId } = useParams();
	const { data, error, isLoading, isFetching, isError } = useTripByIdQuery(
		tripId ?? skipToken
	);

	if (isLoading || isFetching) {
		return (
			<PrivatePage navigation={<NavListDashboard />}>
				<Loading />
			</PrivatePage>
		);
	}

	if (isError || !data || !tripId) {
		return (
			<PrivatePage navigation={<NavListDashboard />}>
				<ErrorDisplay isError={isError} error={error} />
			</PrivatePage>
		);
	}

	return (
		<PrivatePage navigation={<NavListDashboard />}>
			<div class="trip-view">
				<h1>{data.name}</h1>

				<AddImageForm />

				<TripMap />

				<PhotosList />
			</div>
		</PrivatePage>
	);
}
