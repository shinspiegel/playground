import { NavList } from "../components/NavList";
import { PublicPage } from "../layout/publicPage";

export function Unauthorized() {
	return (
		<PublicPage>
			<NavList />
			Unauthorized
		</PublicPage>
	);
}
