import { useRef } from "preact/hooks";
import { useLoginMutation } from "../redux/apiStore";
import { ErrorDisplay } from "./ErrorDisplay";

export function LoginForm() {
	const [login, { isError, error }] = useLoginMutation();
	const ref = useRef<HTMLFormElement>(null);

	function onSubmit(e: SubmitEvent) {
		e.preventDefault();
		if (!ref.current) return console.error("missing form");
		login(new FormData(ref.current));
	}

	return (
		<form ref={ref} onSubmit={onSubmit}>
			<label>
				Login
				<input type="email" name="email" />
			</label>
			<label>
				Password
				<input type="password" name="password" />
			</label>

			<button type="submit">Login</button>

			<ErrorDisplay isError={isError} error={error} />
		</form>
	);
}
