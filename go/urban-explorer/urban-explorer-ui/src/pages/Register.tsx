import { NavList } from "../components/NavList";
import { PublicPage } from "../layout/publicPage";
import { ReactComponent as InfoLogo } from "../assets/info.svg";
import "./Register.scss";
import { getText } from "../functions/getText";

export function Register() {
	const { register } = getText();
	return (
		<PublicPage className="register-page">
			<InfoLogo className="register-page__icon" />
			<div>{register.notAvailable}</div>
			<NavList />
		</PublicPage>
	);
}
