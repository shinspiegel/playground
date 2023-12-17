import { getHomePhrase } from "../functions/getHomePhrase";
import { WithClassName } from "../type";
import { AnimatedLogo } from "./AnimatedLogo";
import "./HomeHero.scss";

export function HomeHero({ className }: WithClassName) {
	const [partOne, partTwo] = getHomePhrase();

	return (
		<div class={["home-hero", className].filter(Boolean).join(" ")}>
			<AnimatedLogo className="home-hero__logo" />
			<h1 class="home-hero__title">Urban Explorer</h1>
			<p class="home-hero__sub">{partOne}</p>
			<p class="home-hero__sub">{partTwo}</p>
		</div>
	);
}
