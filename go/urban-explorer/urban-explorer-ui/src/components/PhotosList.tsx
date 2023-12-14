import { Photo } from "../type";
import { PhotoEntry } from "./PhotoEntry";

type PhotosListProps = {
	list?: Photo[];
};

export function PhotosList({ list = [] }: PhotosListProps) {
	return (
		<div>
			<h1>Photos</h1>

			{list.map((p) => (
				<PhotoEntry key={p.id} item={p} />
			))}
		</div>
	);
}
