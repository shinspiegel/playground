import { NavListDashboard } from "../components/NavListDashboard";
import { NewTripForm } from "../components/NewTripForm";
import { TripsList } from "../components/TripsList";
import { PrivatePage } from "../layout/PrivatePage";
import { useLogoutMutation } from "../redux/apiStore";
import { ROOT } from "../routes";

export function Dashboard() {
	const [logout] = useLogoutMutation();

	function onLogout() {
		logout()
			.unwrap()
			.then(() => window.location.replace(ROOT))
			.catch((err) => console.error(err));
	}

	return (
		<PrivatePage>
			<div>Dashboard</div>
			<button onClick={onLogout}>Logout</button>
			<NewTripForm />
			<TripsList />
			<NavListDashboard />
		</PrivatePage>
	);
}
