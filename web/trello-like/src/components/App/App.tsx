import { useDispatch, useSelector } from "react-redux";
import { RootState } from "../../store/store";
import { todoSlice } from "../../store/todosSlice";
import { Column } from "../Column";

import "./App.scss";

export function App() {
  const { doing, done, todo } = useSelector((state: RootState) => state.todo);
  const dispatch = useDispatch();

  return (
    <div>
      <h1>Local Trello</h1>

      <Column title="Todo" list={todo} setList={(list) => dispatch(todoSlice.actions.setTodo(list))} />
      <Column title="Doing" list={doing} setList={(list) => dispatch(todoSlice.actions.setDoing(list))} />
      <Column title="Done" list={done} setList={(list) => dispatch(todoSlice.actions.setDone(list))} />
    </div>
  );
}
