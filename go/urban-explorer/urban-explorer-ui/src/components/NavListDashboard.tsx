import { getText } from "../functions/getText";
import { DASHBOARD } from "../routes";
import { NavItemLink } from "./NavItemLink";
import { NavList } from "./NavList";

export function NavListDashboard() {
	const { navList } = getText();

	return (
		<NavList>
			<NavItemLink to={DASHBOARD}>{navList.dashboard}</NavItemLink>
		</NavList>
	);
}
