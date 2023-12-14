import { Link } from "react-router-dom";

export function NavList() {
	return (
		<nav>
			<ul>
				<li>
					<Link to="/login">login</Link>
				</li>
				<li>
					<Link to="/register">register</Link>
				</li>
				<li>
					<Link to="/dashboard">dashboard</Link>
				</li>
			</ul>
		</nav>
	);
}
