import { createSlice, PayloadAction } from "@reduxjs/toolkit";
import { statToMod, modToStat } from "../../functions";
import { statsChart } from "../charts";

export type StatsState = {
  list: Stat[];
};

export type Stat = {
  name: string;
  short: string;
  value: number;
  mod: number;
  weight: number;
  isProf?: boolean;
};

const initialState: StatsState = {
  list: statsChart,
};

export const statsSlice = createSlice({
  name: "stats",
  initialState,
  reducers: {
    changeValueFor: (state, action: PayloadAction<{ name: string; value: number }>) => {
      const stat = state.list.find((f) => f.name === action.payload.name);

      if (stat) {
        stat.value = action.payload.value;
        stat.mod = statToMod(action.payload.value);
      }
    },

    changeModFor: (state, action: PayloadAction<{ name: string; value: number }>) => {
      const stat = state.list.find((f) => f.name === action.payload.name);

      if (stat) {
        stat.value = modToStat(action.payload.value);
        stat.mod = action.payload.value;
      }
    },

    setSaveProficiencyFor: (state, action: PayloadAction<{ name: string; value: boolean }>) => {
      const stat = state.list.find((f) => f.name === action.payload.name);

      if (stat) {
        stat.isProf = action.payload.value;
      }
    },
  },
});
