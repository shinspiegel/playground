import { NavList } from "../components/NavList";
import { PublicPage } from "../layout/publicPage";

export function Root() {
	return (
		<PublicPage>
			<div>Root</div>
			<NavList />
		</PublicPage>
	);
}
