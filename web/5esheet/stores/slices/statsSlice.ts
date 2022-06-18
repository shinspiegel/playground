import { createSlice, PayloadAction } from "@reduxjs/toolkit";
import { statToMod } from "../../functions";
import { modToStat } from "../../functions/modToStat";
import { RootState } from "../store";

export type StatsState = {
  list: Stat[];
};

export type Stat = {
  name: string;
  short: string;
  value: number;
  mod: number;
  weight: number;
};

const initialState: StatsState = {
  list: [
    { name: "Strength", short: "STR", value: 8, mod: -1, weight: 0 },
    { name: "Dexterity", short: "DEX", value: 10, mod: 0, weight: 1 },
    { name: "Constitution", short: "CON", value: 12, mod: 1, weight: 2 },
    { name: "Intelligence", short: "INT", value: 14, mod: 2, weight: 3 },
    { name: "Wisdom", short: "WIS", value: 16, mod: 3, weight: 4 },
    { name: "Charisma", short: "CHA", value: 18, mod: 4, weight: 5 },
  ],
};

export type UpdateStateOpt = {
  name: string;
  type: keyof Pick<Stat, "value" | "mod">;
  value: number;
};

export const statsSlice = createSlice({
  name: "stats",
  initialState,
  reducers: {
    updateState: (state, action: PayloadAction<UpdateStateOpt>) => {
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
  },
});

export const { updateState } = statsSlice.actions;
