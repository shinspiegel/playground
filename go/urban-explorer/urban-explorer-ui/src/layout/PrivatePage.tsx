import { PropsWithChildren, useEffect, useState } from "preact/compat";
import { AUTH_CHECK_API } from "../constants/apiRoutes";
import { Unauthorized } from "../components/Unauthorized";
import { Loading } from "../components/Loading";

export function PrivatePage({ children }: PropsWithChildren) {
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
		return <Unauthorized />;
	}

	return <>{children}</>;
}
