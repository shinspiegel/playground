import { Link, useNavigate } from "react-router-dom";
import { LoginForm } from "../components/LoginForm";
import { PublicPage } from "../layout/publicPage";
import { DASHBOARD, ROOT } from "../routes";
import { useCheckQuery } from "../redux/apiStore";
import { AnimatedLogo } from "../components/AnimatedLogo";
import { getText } from "../functions/getText";
import { NavListAuth } from "../components/NavListAuth";
import "./Login.scss";

export function Login() {
	const { login } = getText();
	const navigation = useNavigate();
	const { isSuccess } = useCheckQuery();

	if (isSuccess) {
		navigation(DASHBOARD);
		return <></>;
	}

	return (
		<PublicPage className="login-page">
			<AnimatedLogo className="login-page__logo" />
			<LoginForm />
			<Link to={ROOT}>{login.back}</Link>
			<NavListAuth />
		</PublicPage>
	);
}
