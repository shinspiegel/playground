import { getText } from "../functions/getText";
import { useLogoutMutation } from "../redux/apiStore";
import { DASHBOARD, ROOT } from "../routes";
import { NewTripButton } from "./NewTripButton";
import { NavItemLink } from "./NavItemLink";
import { NavList } from "./NavList";
import "./NavListDashboard.scss";

export function NavListDashboard() {
	const { navList } = getText();
	const [logout] = useLogoutMutation();

	function onLogout() {
		logout()
			.unwrap()
			.then(() => window.location.replace(ROOT))
			.catch((err) => console.error(err));
	}

	return (
		<NavList className="nav-list-dashboard">
			<NewTripButton />
			<NavItemLink to={DASHBOARD}>{navList.dashboard}</NavItemLink>
			<button className="nav-list-dashboard__button" onClick={onLogout}>
				{navList.logout}
			</button>
		</NavList>
	);
}
