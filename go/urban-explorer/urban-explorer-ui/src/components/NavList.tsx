import { PropsWithChildren } from "preact/compat";
import "./NavList.scss";
import { WithClassName } from "../type";

type NavListProps = PropsWithChildren & WithClassName;

export function NavList({ className, children }: NavListProps) {
	const names = ["nav-list"];
	if (className) names.push(className);

	return (
		<nav class={names.join(" ")}>
			<ul class="nav-list__list">{children}</ul>
		</nav>
	);
}
