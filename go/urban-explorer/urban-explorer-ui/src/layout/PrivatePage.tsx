import { PropsWithChildren } from "preact/compat";
import { Loading } from "../components/Loading";
import { useNavigate } from "react-router-dom";
import { UNAUTHORIZE } from "../routes";
import { useCheckQuery } from "../redux/apiStore";

export function PrivatePage({ children }: PropsWithChildren) {
	const { isFetching, isLoading, isError } = useCheckQuery();
	const navigate = useNavigate();

	if (isLoading || isFetching) {
		return <Loading />;
	}

	if (isError) {
		navigate(UNAUTHORIZE);
		return <></>;
	}

	return <>{children}</>;
}
