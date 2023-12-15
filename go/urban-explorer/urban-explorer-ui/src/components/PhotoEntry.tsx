import { useDialog } from "../hooks/useDialog";
import { Photo } from "../type";
import { DialogWindow } from "./DialogWindow";
import { TripPhoto } from "./TripPhoto";

type PhotoEntryProps = {
	item: Photo;
};

export function PhotoEntry({ item }: PhotoEntryProps) {
	const { isOpen, close, open } = useDialog();

	return (
		<div>
			<div>{item.id}</div>
			<div>
				{item.latitude} - {item.longitude}
			</div>
			<div>{item.timestamp}</div>
			<TripPhoto photo={item} />
			<button onClick={open}>Delete Photo</button>

			<DialogWindow isOpen={isOpen} onClose={close}>
				<button onClick={() => {}}>Confirm deletion</button>
			</DialogWindow>
		</div>
	);
}
