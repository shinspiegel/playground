import { ReactComponent as LowerPart } from "../assets/LowerPart.svg";
import { ReactComponent as UpperPart } from "../assets/UpperPart.svg";
import { ReactComponent as OuterCircle } from "../assets/OuterCircle.svg";
import { WithClassName } from "../type";
import "./Loading.scss";
import { getText } from "../functions/getText";

export function Loading({ className }: WithClassName) {
	const names = ["loading"];
	if (className) names.push(className);

	return (
		<div class={names.join(" ")}>
			<UpperPart class="loading__upper" />
			<LowerPart class="loading__lower" />
			<OuterCircle class="loading__outer" />
		</div>
	);
}
