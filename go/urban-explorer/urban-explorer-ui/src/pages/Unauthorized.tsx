import { PublicPage } from "../layout/publicPage";
import { ReactComponent as StopIcon } from "../assets/Stop.svg";
import { Link } from "react-router-dom";
import { ROOT } from "../routes";
import { getText } from "../functions/getText";
import { NavListAuth } from "../components/NavListAuth";
import "./Unauthorized.scss";

export function Unauthorized() {
	const { unauthorized } = getText();
	return (
		<PublicPage navigation={<NavListAuth />}>
			<div className="unauthorized-page">
				<StopIcon class="unauthorized-page__icon" />
				<p>{unauthorized.message}</p>
				<Link to={ROOT}>{unauthorized.back}</Link>
			</div>
		</PublicPage>
	);
}
