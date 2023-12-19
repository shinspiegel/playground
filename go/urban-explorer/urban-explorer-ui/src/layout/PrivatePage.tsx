import { PropsWithChildren } from "preact/compat";
import { Loading } from "../components/Loading";
import { useNavigate } from "react-router-dom";
import { UNAUTHORIZE } from "../routes";
import { useCheckQuery } from "../redux/apiStore";
import { WithClassName } from "../type";
import { ComponentChild } from "preact";
import "./BasePage.scss";

type PrivatePageProps = { navigation?: ComponentChild } & WithClassName &
	PropsWithChildren;

export function PrivatePage({
	className,
	navigation,
	children,
}: PrivatePageProps) {
	const { isFetching, isLoading, isError } = useCheckQuery();
	const navigate = useNavigate();
	const names = ["base-page"];
	if (className) names.push(className);

	if (isLoading || isFetching) {
		return <Loading />;
	}

	if (isError) {
		navigate(UNAUTHORIZE);
		return <></>;
	}

	return (
		<main class={names.join(" ")}>
			<div class="base-page__content">{children}</div>
			{navigation && (
				<div class="base-page__navigation">{navigation}</div>
			)}
		</main>
	);
}
