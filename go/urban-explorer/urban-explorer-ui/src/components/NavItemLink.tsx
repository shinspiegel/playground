import { PropsWithChildren } from "preact/compat";
import { WithClassName } from "../type";
import { Link, useLocation } from "react-router-dom";
import { ROOT } from "../routes";
import "./NavItemLink.scss";

type NavItemLinkProps = { to: string } & WithClassName & PropsWithChildren;

export function NavItemLink({ to, className, children }: NavItemLinkProps) {
	const { pathname } = useLocation();
	const names = ["nav-item-link"];
	if (className) names.push(className);
	if ((to != ROOT && pathname.includes(to)) || (to == ROOT && pathname == ROOT)) names.push("nav-item-link--active");

	return (
		<li className={names.join(" ")}>
			<Link to={to}>{children}</Link>
		</li>
	);
}
