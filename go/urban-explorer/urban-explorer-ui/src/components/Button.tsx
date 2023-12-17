import { PropsWithChildren } from "preact/compat";
import { WithClassName } from "../type";
import "./Button.scss";

type ButtonProps = {
	onClick?: () => void;
	size?: "big" | "medium" | "small";
	color?: "default" | "primary";
} & PropsWithChildren &
	WithClassName;

export function Button({ onClick, size = "medium", color = "default", className, children }: ButtonProps) {
	const names = ["button"];

	if (className) names.push(className);
	if (size) names.push(`button--${size}`);
	if (color) names.push(`button--${color}`);

	return (
		<button class={names.join(" ")} onClick={onClick}>
			{children}
		</button>
	);
}
