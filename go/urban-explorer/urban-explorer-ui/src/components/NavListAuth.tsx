import { getText } from "../functions/getText";
import { LOGIN, REGISTER } from "../routes";
import { NavItemLink } from "./NavItemLink";
import { NavList } from "./NavList";

export function NavListAuth() {
	const { navList } = getText();

	return (
		<NavList>
			<NavItemLink to={LOGIN}>{navList.login}</NavItemLink>
			<NavItemLink to={REGISTER}>{navList.register}</NavItemLink>
		</NavList>
	);
}
