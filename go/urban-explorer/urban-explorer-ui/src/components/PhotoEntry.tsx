import { useDialog } from "../hooks/useDialog";
import { useDeletePhotoByIdMutation } from "../redux/apiStore";
import { Photo } from "../type";
import { DialogWindow } from "./DialogWindow";
import { TripPhoto } from "./TripPhoto";
import "./PhotoEntry.scss";
import { getText } from "../functions/getText";
import { Button } from "./Button";

type PhotoEntryProps = {
	item: Photo;
};

export function PhotoEntry({ item }: PhotoEntryProps) {
	const { tripView } = getText();
	const { isOpen, close, open } = useDialog();
	const [del] = useDeletePhotoByIdMutation();

	function onDelete() {
		del(item.id);
		close();
	}

	return (
		<div class="photo-entry">
			<div class="photo-entry__time">
				{new Date(item.timestamp).toLocaleDateString()} -
				{new Date(item.timestamp).toLocaleTimeString()}
			</div>
			<TripPhoto className="photo-entry__photo" photo={item} />
			<button className="photo-entry__button" onClick={open}>
				{tripView.delete}
			</button>

			<DialogWindow className="photo-entry__dialog" isOpen={isOpen}>
				<h4>{tripView.delete}</h4>
				<Button color="danger" onClick={onDelete}>
					{tripView.confirm}
				</Button>
				<Button onClick={close}>{tripView.cancel}</Button>
			</DialogWindow>
		</div>
	);
}
