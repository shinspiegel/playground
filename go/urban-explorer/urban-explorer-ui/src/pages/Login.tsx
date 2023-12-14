import { useNavigate } from "react-router-dom";
import { LoginForm } from "../components/LoginForm";
import { NavList } from "../components/NavList";
import { AUTH_CHECK_API } from "../constants/apiRoutes";
import { PublicPage } from "../layout/publicPage";
import { DASHBOARD } from "../routes";

export function Login() {
	const navigation = useNavigate();
	fetch(AUTH_CHECK_API, { credentials: "include" })
		.then((res) => {
			if (res.ok) navigation(DASHBOARD);
		})
		.catch((err) => console.error(err));

	return (
		<PublicPage>
			<div>Login</div>
			<NavList />
			<LoginForm />
		</PublicPage>
	);
}
