import { ReactComponent as LowerPart } from "../assets/LowerPart.svg";
import { ReactComponent as UpperPart } from "../assets/UpperPart.svg";
import { ReactComponent as OuterCircle } from "../assets/OuterCircle.svg";
import "./AnimatedLogo.scss";

type AnimatedLogoProps = {
	className?: string;
};

export function AnimatedLogo({ className }: AnimatedLogoProps) {
	const names = ["animated-logo"];
	if (className) {
		names.push(className);
	}

	return (
		<div class={names.join(" ")}>
			<LowerPart class="animated-logo__lower" />
			<UpperPart class="animated-logo__upper" />
			<OuterCircle class="animated-logo__outer" />
		</div>
	);
}
