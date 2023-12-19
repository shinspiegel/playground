import { getText } from "../functions/getText";
import { useLogoutMutation } from "../redux/apiStore";
import { DASHBOARD, ROOT } from "../routes";
import { FloatingNewTripButton } from "./FloatingNewTripButton";
import { NavItemLink } from "./NavItemLink";
import { NavList } from "./NavList";

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
		<NavList>
			<NavItemLink to={DASHBOARD}>{navList.dashboard}</NavItemLink>
			<FloatingNewTripButton />
			<button onClick={onLogout}>Logout</button>
		</NavList>
	);
}
