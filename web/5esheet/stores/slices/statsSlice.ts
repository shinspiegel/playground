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

type Updater<Type, Value> = {
  name: string;
  type: Type;
  value: Value;
};

export type UpdateStateOpt = Updater<keyof Pick<Stat, "value" | "mod">, number>;

export type SetStatSave = Updater<keyof Pick<Stat, "isProf">, boolean>;

const initialState: StatsState = {
  list: statsChart,
};

export const statsSlice = createSlice({
  name: "stats",
  initialState,
  reducers: {
    updateStatValue: (state, action: PayloadAction<UpdateStateOpt>) => {
      const stat = state.list.find((f) => f.name === action.payload.name);

      if (stat) {
        if (action.payload.type === "value") {
          stat.value = action.payload.value;
          stat.mod = statToMod(action.payload.value);
        }

        if (action.payload.type === "mod") {
          stat.value = modToStat(action.payload.value);
          stat.mod = action.payload.value;
        }
      }
    },

    setStatSave: (state, action: PayloadAction<SetStatSave>) => {
      const stat = state.list.find((f) => f.name === action.payload.name);

      if (stat) {
        stat.isProf = action.payload.value;
      }
    },
  },
});

export const { updateStatValue, setStatSave } = statsSlice.actions;
