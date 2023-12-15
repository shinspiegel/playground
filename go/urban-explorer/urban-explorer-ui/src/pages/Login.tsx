import { useNavigate } from "react-router-dom";
import { LoginForm } from "../components/LoginForm";
import { NavList } from "../components/NavList";
import { PublicPage } from "../layout/publicPage";
import { DASHBOARD } from "../routes";
import { useCheckQuery } from "../redux/apiStore";

export function Login() {
	const navigation = useNavigate();
	const { isSuccess } = useCheckQuery();

	if (isSuccess) {
		navigation(DASHBOARD);
	}

	return (
		<PublicPage>
			<div>Login</div>
			<NavList />
			<LoginForm />
		</PublicPage>
	);
}
