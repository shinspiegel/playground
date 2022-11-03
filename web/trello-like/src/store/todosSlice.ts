import { createSlice } from "@reduxjs/toolkit";
import type { PayloadAction } from "@reduxjs/toolkit";

export type TodoItem = {
  id: string;
  text: string;
};

export interface TodoState {
  todo: TodoItem[];
  doing: TodoItem[];
  done: TodoItem[];
}

const initialState: TodoState = {
  todo: [
    { id: "0", text: "zero" },
    { id: "1", text: "one" },
    { id: "2", text: "two" },
  ],
  doing: [],
  done: [],
};

export const todoSlice = createSlice({
  name: "todo",
  initialState,
  reducers: {
    setTodo: (state, action: PayloadAction<TodoItem[]>) => {
      state.todo = action.payload;
    },

    setDoing: (state, action: PayloadAction<TodoItem[]>) => {
      state.doing = action.payload;
    },

    setDone: (state, action: PayloadAction<TodoItem[]>) => {
      state.done = action.payload;
    },
  },
});
