import { HTMLAttributes } from "preact/compat";
import "./LabeledInput.scss";

type LabeledInputProps = { label: string } & HTMLAttributes<HTMLInputElement>;

export function LabeledInput({ label, ...restInput }: LabeledInputProps) {
	return (
		<label class="labeled-input">
			<span class="labeled-input__label">{label}</span>
			<input class="labeled-input__input" {...restInput} />
		</label>
	);
}
