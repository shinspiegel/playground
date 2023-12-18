import { useRef } from "preact/hooks";
import { LabeledInput } from "./LabeledInput";
import { useLoginMutation } from "../redux/apiStore";
import { ErrorDisplay } from "./ErrorDisplay";
import "./LoginForm.scss";
import { Button } from "./Button";
import { getText } from "../functions/getText";

export function LoginForm() {
	const { loginForm } = getText();
	const [login, { isError, error }] = useLoginMutation();
	const ref = useRef<HTMLFormElement>(null);

	function onSubmit(e: SubmitEvent) {
		e.preventDefault();
		if (!ref.current) return console.error("missing form");
		login(new FormData(ref.current));
	}

	return (
		<form class="login-form" ref={ref} onSubmit={onSubmit}>
			<LabeledInput name="email" label={loginForm.email} type="email" />
			<LabeledInput
				name="password"
				label={loginForm.password}
				type="password"
			/>
			<Button type="submit">{loginForm.login}</Button>
			<ErrorDisplay isError={isError} error={error} />
		</form>
	);
}
