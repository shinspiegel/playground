import { useEffect, useState } from "preact/hooks";

type UseFetch<T> = {
	data?: T;
	loading?: boolean;
	error?: string;
	refresh(): void;
};

export function useFetch<T>(url: string, init: RequestInit): UseFetch<T> {
	const [_refresh, setRefresh] = useState(true);
	const [data, setData] = useState<T>();
	const [loading, setLoading] = useState(true);
	const [error, setError] = useState<string>();

	useEffect(() => {
		if (_refresh) {
			console.log("Refresh");
			fetch(url, init)
				.then((res) => res.json())
				.then((resData) => {
					setLoading(false);
					setData(resData);
				})
				.catch((err) => {
					console.error(err);
					setError(err?.message ?? "unknown error");
				})
				.finally(() => {
					setRefresh(false);
					setLoading(false);
				});
		}
	}, [_refresh]);

	function refresh() {
		setLoading(true);
		setRefresh(true);
	}

	return { data, loading, error, refresh };
}
