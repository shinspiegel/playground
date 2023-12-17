import { useNavigate } from "react-router-dom";
import { Button } from "../components/Button";
import { HomeHero } from "../components/HomeHero";
import { PublicPage } from "../layout/publicPage";
import { LOGIN } from "../routes";
import "./Root.scss";

export function Root() {
	const navigate = useNavigate();

	return (
		<PublicPage className="root-page">
			<HomeHero className="root-page__hero" />
			<Button onClick={() => navigate(LOGIN)} className="root-page__button" size="big" color="primary">
				Login
			</Button>

			<footer class="root-page__footer">
				<small>Jeferson Leite Borges. All rights reserved.</small>
			</footer>
		</PublicPage>
	);
}
