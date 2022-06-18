import { configureStore } from "@reduxjs/toolkit";
import { statsSlice } from "./slices/statsSlice";

export const store = configureStore({
  reducer: {
    [statsSlice.name]: statsSlice.reducer,
  },
});

export type RootState = ReturnType<typeof store.getState>;
export type AppDispatch = typeof store.dispatch;
