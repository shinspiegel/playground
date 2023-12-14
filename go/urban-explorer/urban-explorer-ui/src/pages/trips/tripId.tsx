import { useParams } from "react-router-dom";
import { NavList } from "../../components/NavList";
import { PrivatePage } from "../../layout/PrivatePage";
import { useFetch } from "../../hooks/useFetch";
import { TRIP_TRIPID_API } from "../../constants/apiRoutes";
import { useReplace } from "../../hooks/useReplace";
import { AddImageForm } from "../../components/AddImageForm";
import { Trip } from "../../type";
import { PhotosList } from "../../components/PhotosList";

export function TripId() {
	const { tripId } = useParams();
	const url = useReplace(`${TRIP_TRIPID_API}?include-photos=true`, { tripId });
	const { data, loading, error, refresh } = useFetch<Trip>(url, { credentials: "include" });

	if (loading) {
		return <div>Loading</div>;
	}

	if (error || !tripId) {
		return <div>Failed to load: {error} </div>;
	}

	return (
		<PrivatePage>
			<NavList />
			<h1>Trip ({tripId})</h1>

			<AddImageForm tripId={tripId} onAddImage={() => refresh()} />

			<PhotosList list={data?.photos?.sort((a, b) => a.timestamp - b.timestamp)} />
		</PrivatePage>
	);
}
