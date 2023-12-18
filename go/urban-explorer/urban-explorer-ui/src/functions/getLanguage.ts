export function getLanguage(): string {
	if (
		navigator.language.toLowerCase().includes("pt") ||
		navigator.language.toLowerCase().includes("br")
	)
		return "pt";

	return "en";
}
