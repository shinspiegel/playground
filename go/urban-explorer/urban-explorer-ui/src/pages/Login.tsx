import { Link, useNavigate } from "react-router-dom";
import { LoginForm } from "../components/LoginForm";
import { NavList } from "../components/NavList";
import { PublicPage } from "../layout/publicPage";
import { DASHBOARD, ROOT } from "../routes";
import { useCheckQuery } from "../redux/apiStore";
import "./Login.scss";
import { AnimatedLogo } from "../components/AnimatedLogo";

export function Login() {
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
			<Link to={ROOT}>Back Home</Link>
			<NavList />
		</PublicPage>
	);
}
