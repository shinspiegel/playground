import { configureStore } from "@reduxjs/toolkit";
import { appApi } from "./apiStore";

export const appStore = configureStore({
	reducer: { [appApi.reducerPath]: appApi.reducer },
	middleware: (getDefaultMiddleware) => getDefaultMiddleware().concat(appApi.middleware),
});

export type RootState = ReturnType<typeof appStore.getState>;
export type AppDispatch = typeof appStore.dispatch;
