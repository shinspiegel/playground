import { NavListDashboard } from "../components/NavListDashboard";
import { TripsList } from "../components/TripsList";
import { getText } from "../functions/getText";
import { PrivatePage } from "../layout/PrivatePage";
import "./Dashboard.scss";

export function Dashboard() {
	const { dashboard } = getText();

	return (
		<PrivatePage navigation={<NavListDashboard />}>
			<div className="dashboard-page">
				<h1 className="dashboard-page__title">{dashboard.title}</h1>
				<TripsList />
			</div>
		</PrivatePage>
	);
}
