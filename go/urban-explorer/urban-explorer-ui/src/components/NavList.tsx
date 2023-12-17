import { Link } from "react-router-dom";
import { useLogoutMutation } from "../redux/apiStore";
import { ROOT } from "../routes";

export function NavList() {
	const [logout] = useLogoutMutation();

	function onLogout() {
		logout()
			.unwrap()
			.then(() => window.location.replace(ROOT))
			.catch((err) => console.error(err));
	}

	return (
		<nav>
			<ul>
				<li>
					<Link to="/">home</Link>
				</li>
				<li>
					<Link to="/login">login</Link>
				</li>
				<li>
					<Link to="/register">register</Link>
				</li>
				<li>
					<Link to="/dashboard">dashboard</Link>
				</li>
				<li>
					<button onClick={onLogout}>logout</button>
				</li>
			</ul>
		</nav>
	);
}
