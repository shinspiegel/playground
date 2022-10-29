import Sortable from "sortablejs";
import { EntryColumn } from "./EntryColumn";

const [backlog, progress, done] = ["backlog", "progress", "done"].map(
  (name) => new EntryColumn({ name, draggableClassName: "draggable-list" })
);

document.querySelectorAll(".draggable-list").forEach((list) => {
  new Sortable(list as HTMLElement, {
    group: "shared",
    animation: 150,
    ghostClass: "ghost",
    onEnd() {
      [backlog, progress, done].forEach((i) => i.update());
    },
  });
});
