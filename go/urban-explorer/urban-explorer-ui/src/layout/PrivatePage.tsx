import { PropsWithChildren } from "preact/compat";
import { Loading } from "../components/Loading";
import { useNavigate } from "react-router-dom";
import { UNAUTHORIZE } from "../routes";
import { useCheckQuery } from "../redux/apiStore";
import { WithClassName } from "../type";

type PrivatePageProps = WithClassName & PropsWithChildren;

export function PrivatePage({ className, children }: PrivatePageProps) {
	const { isFetching, isLoading, isError } = useCheckQuery();
	const navigate = useNavigate();

	if (isLoading || isFetching) {
		return <Loading />;
	}

	if (isError) {
		navigate(UNAUTHORIZE);
		return <></>;
	}

	return <main class={className}>{children}</main>;
}
