import { NavList } from "../components/NavList";
import { PublicPage } from "../layout/publicPage";
import { ReactComponent as InfoLogo } from "../assets/info.svg";
import "./Register.scss";

export function Register() {
	return (
		<PublicPage className="register-page">
			<InfoLogo className="register-page__icon" />
			<div>Not available</div>
			<NavList />
		</PublicPage>
	);
}
