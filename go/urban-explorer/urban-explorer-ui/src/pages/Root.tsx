import { useNavigate } from "react-router-dom";
import { Button } from "../components/Button";
import { HomeHero } from "../components/HomeHero";
import { PublicPage } from "../layout/publicPage";
import { LOGIN } from "../routes";
import { getText } from "../functions/getText";
import "./Root.scss";

export function Root() {
	const navigate = useNavigate();
	const { root } = getText();

	return (
		<PublicPage>
			<div className="root-page">
				<HomeHero className="root-page__hero" />
				<Button
					onClick={() => navigate(LOGIN)}
					className="root-page__button"
					size="big"
					color="primary"
				>
					{root.login}
				</Button>

				<footer class="root-page__footer">
					<small>{root.bottom}</small>
				</footer>
			</div>
		</PublicPage>
	);
}
