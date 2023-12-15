type ErrorDisplayProps = {
	isError?: boolean;
	error?: any;
};

export function ErrorDisplay({ error, isError }: ErrorDisplayProps) {
	if (!isError || !error) {
		return <></>;
	}

	return <span>{error?.data?.message ?? "unknown error"}</span>;
}
