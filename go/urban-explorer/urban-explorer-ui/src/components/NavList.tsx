import { PropsWithChildren } from "preact/compat";
import "./NavList.scss";

export function NavList({ children }: PropsWithChildren) {
	return (
		<nav class="nav-list">
			<ul class="nav-list__list">{children}</ul>
		</nav>
	);
}
