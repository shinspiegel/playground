import { PropsWithChildren } from "preact/compat";
import { WithClassName } from "../type";
import { ComponentChild } from "preact";
import "./BasePage.scss";

type PublicPageProps = { navigation?: ComponentChild } & WithClassName &
	PropsWithChildren;

export function PublicPage({
	className,
	navigation,
	children,
}: PublicPageProps) {
	const names = ["base-page"];
	if (className) names.push(className);

	return (
		<main class={names.join(" ")}>
			<div class="base-page__content">{children}</div>
			{navigation && (
				<div class="base-page__navigation">{navigation}</div>
			)}
		</main>
	);
}
