import { NavList } from "../components/NavList";
import { NewTripForm } from "../components/NewTripForm";
import { TripsList } from "../components/TripsList";
import { PrivatePage } from "../layout/PrivatePage";

export function Dashboard() {
	return (
		<PrivatePage>
			<div>Dashboard</div>
			<NavList />
			<NewTripForm />
			<TripsList />
		</PrivatePage>
	);
}
