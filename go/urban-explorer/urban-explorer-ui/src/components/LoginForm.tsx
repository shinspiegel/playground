import { useRef } from "preact/hooks";
import { LabeledInput } from "./LabeledInput";
import { useLoginMutation } from "../redux/apiStore";
import { ErrorDisplay } from "./ErrorDisplay";
import { Button } from "./Button";
import { getText } from "../functions/getText";
import "./LoginForm.scss";

export function LoginForm() {
	const { loginForm, general } = getText();
	const [login, { isLoading, isError, error }] = useLoginMutation();
	const ref = useRef<HTMLFormElement>(null);

	function onSubmit(e: SubmitEvent) {
		e.preventDefault();
		if (!ref.current) return console.error("missing form");
		login(new FormData(ref.current));
	}

	if (isLoading) {
		return <div>{general.loading}</div>;
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
