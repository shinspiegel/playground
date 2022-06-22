import { configureStore } from "@reduxjs/toolkit";
import { statsSlice, infoSlice, skillsSlice, proficienciesSlice, combatDataSlice } from "./slices";

export const store = configureStore({
  reducer: {
    [statsSlice.name]: statsSlice.reducer,
    [infoSlice.name]: infoSlice.reducer,
    [skillsSlice.name]: skillsSlice.reducer,
    [proficienciesSlice.name]: proficienciesSlice.reducer,
    [combatDataSlice.name]: combatDataSlice.reducer,
  },
});

export type RootState = ReturnType<typeof store.getState>;
export type AppDispatch = typeof store.dispatch;
