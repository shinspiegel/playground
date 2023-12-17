import { WithClassName } from "../type";
import "./ErrorDisplay.scss";

type ErrorDisplayProps = {
	isError?: boolean;
	error?: any;
} & WithClassName;

export function ErrorDisplay({ error, isError, className }: ErrorDisplayProps) {
	if (!isError || !error) {
		return <></>;
	}

	const names = ["error-display"];
	if (className) names.push(className);

	return <div class={names.join(" ")}>{error?.data?.message ?? "unknown error"}</div>;
}
