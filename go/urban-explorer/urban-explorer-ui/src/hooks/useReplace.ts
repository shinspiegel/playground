export function useReplace(url: string, replacer: Record<string, string | number | undefined>): string {
	for (const key in replacer) {
		const data = replacer[key];

		if (!data) continue;

		if (typeof data === "number") {
			url = url.replaceAll(`:${key}`, data.toString());
		} else {
			url = url.replaceAll(`:${key}`, data);
		}
	}

	return url;
}
