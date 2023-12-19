import { PublicPage } from "../layout/publicPage";
import { ReactComponent as InfoLogo } from "../assets/info.svg";
import { getText } from "../functions/getText";
import { NavListAuth } from "../components/NavListAuth";
import "./Register.scss";

export function Register() {
	const { register } = getText();
	return (
		<PublicPage navigation={<NavListAuth />}>
			<div className="register-page">
				<InfoLogo className="register-page__icon" />
				<div>{register.notAvailable}</div>
			</div>
		</PublicPage>
	);
}
