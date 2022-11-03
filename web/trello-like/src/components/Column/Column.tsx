import { ItemInterface, ReactSortable } from "react-sortablejs";
import { TodoItem } from "../TodoItem";
import "./Column.scss";

export type ColumnProp = {
  title: string;
  list: TodoItem[];
  setList: (list: TodoItem[]) => void;
};

export function Column({ list, setList, title }: ColumnProp) {
  return (
    <div>
      <h2>{title}</h2>
      <ul>
        <ReactSortable list={list} setList={setList}>
          {list ? list.map((item) => <TodoItem key={item.id} {...item} />) : null}
        </ReactSortable>
      </ul>

      <form>
        <label>
          <span>Title</span>
          <input />
        </label>
      </form>
    </div>
  );
}
