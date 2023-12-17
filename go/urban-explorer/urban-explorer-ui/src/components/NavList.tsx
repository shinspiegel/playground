import { LOGIN, REGISTER } from "../routes";
import { NavItemLink } from "./NavItemLink";
import "./NavList.scss";

export function NavList() {
	return (
		<nav class="nav-list">
			<ul class="nav-list__list">
				<NavItemLink to={LOGIN}>Login</NavItemLink>
				<NavItemLink to={REGISTER}>Register</NavItemLink>
			</ul>
		</nav>
	);
}
