import { PropsWithChildren, useEffect, useState } from "preact/compat";
import { AUTH_CHECK_API } from "../constants/apiRoutes";
import { Loading } from "../components/Loading";
import { useNavigate } from "react-router-dom";
import { UNAUTHORIZE } from "../routes";

export function PrivatePage({ children }: PropsWithChildren) {
	const navigate = useNavigate();
	const [allowed, setAllowed] = useState<boolean>(false);
	const [loading, setLoading] = useState<boolean>(true);

	useEffect(() => {
		fetch(AUTH_CHECK_API, { credentials: "include" })
			.then((res) => {
				if (res.ok) {
					setAllowed(true);
				}
			})
			.catch((err) => {
				console.error(err);
			})
			.finally(() => {
				setLoading(false);
			});
	}, []);

	if (loading) {
		return <Loading />;
	}

	if (!allowed) {
		navigate(UNAUTHORIZE);
		return <></>;
	}

	return <>{children}</>;
}
