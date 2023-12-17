import { useRef } from "preact/hooks";
import { LabeledInput } from "./LabeledInput";
import { useLoginMutation } from "../redux/apiStore";
import { ErrorDisplay } from "./ErrorDisplay";
import "./LoginForm.scss";
import { Button } from "./Button";

export function LoginForm() {
	const [login, { isError, error }] = useLoginMutation();
	const ref = useRef<HTMLFormElement>(null);

	function onSubmit(e: SubmitEvent) {
		e.preventDefault();
		if (!ref.current) return console.error("missing form");
		login(new FormData(ref.current));
	}

	return (
		<form class="login-form" ref={ref} onSubmit={onSubmit}>
			<LabeledInput name="email" label="Email" type="email" />
			<LabeledInput name="password" label="Password" type="password" />
			<Button type="submit">Login</Button>
			<ErrorDisplay isError={isError} error={error} />
		</form>
	);
}
