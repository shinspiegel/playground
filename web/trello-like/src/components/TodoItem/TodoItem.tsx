import { TodoItem as TodoItemProp } from "../../store/todosSlice";

export function TodoItem({ text }: TodoItemProp) {
  return <div>{text}</div>;
}
