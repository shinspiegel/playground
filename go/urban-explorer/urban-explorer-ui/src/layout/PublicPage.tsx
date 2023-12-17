import { PropsWithChildren } from "preact/compat";
import { WithClassName } from "../type";

type PublicPageProps = WithClassName & PropsWithChildren;

export function PublicPage({ className, children }: PublicPageProps) {
	return <main class={className}>{children}</main>;
}
