import { useRef, useState } from "preact/hooks";
import { AUTH_LOGIN_API } from "../constants/apiRoutes";
import { useNavigate } from "react-router-dom";
import { DASHBOARD } from "../routes";

export function LoginForm() {
	const [err, setErr] = useState<string>();
	const ref = useRef<HTMLFormElement>(null);
	const navigate = useNavigate();

	function onSubmit(e: SubmitEvent) {
		e.preventDefault();
		if (!ref.current) return console.error("missing form");
		fetch(AUTH_LOGIN_API, {
			credentials: "include",
			method: "POST",
			body: new FormData(ref.current),
		})
			.then((res) => res.json())
			.then((data) => {
				if ("error" in data) throw data;
				navigate(DASHBOARD);
			})
			.catch((err) => {
				console.error(err);
				setErr(err?.message ?? "unknown error");
			});
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

			{err && <span>{err}</span>}
		</form>
	);
}
