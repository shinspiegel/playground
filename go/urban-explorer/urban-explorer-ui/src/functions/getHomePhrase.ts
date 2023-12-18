import { getText } from "./getText";

type Slogan = [string, string];

export function getHomePhrase(): Slogan {
	const { hero } = getText();

	const rand =
		hero.subTitle[Math.floor((Math.random() * 10) % hero.subTitle.length)];

	return rand;
}
