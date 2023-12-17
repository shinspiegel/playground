import { NavList } from "../components/NavList";
import { PublicPage } from "../layout/publicPage";
import { ReactComponent as StopIcon } from "../assets/Stop.svg";
import { Link } from "react-router-dom";
import { ROOT } from "../routes";
import "./Unauthorized.scss";

export function Unauthorized() {
	return (
		<PublicPage className="unauthorized-page">
			<StopIcon class="unauthorized-page__icon" />
			<p>Looks like you don't have the credentials to see this page</p>
			<Link to={ROOT}>Back to home</Link>
			<NavList />
		</PublicPage>
	);
}
