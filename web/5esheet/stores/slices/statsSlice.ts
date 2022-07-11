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
      const value = parseInt(String(action.payload.value));

      if (stat) {
        stat.value = value;
        stat.mod = statToMod(value);
      }
    },

    changeModFor: (state, action: PayloadAction<{ name: string; value: number }>) => {
      const stat = state.list.find((f) => f.name === action.payload.name);
      const value = parseInt(String(action.payload.value));

      if (stat) {
        stat.value = modToStat(value);
        stat.mod = value;
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
