import { getText } from "../functions/getText";
import { useLogoutMutation } from "../redux/apiStore";
import { DASHBOARD } from "../routes";
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
			<button onClick={onLogout}>Logout</button>
		</NavList>
	);
}
