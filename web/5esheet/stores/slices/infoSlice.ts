import { createSlice, PayloadAction } from "@reduxjs/toolkit";
import { levelChart } from "../charts";

export type InfoSlice = {
  name: string;
  race: string;
  class: string;
  player: string;
  level: number;
  experience: number;
};

const initialState: InfoSlice = {
  name: "Dwarfo",
  race: "Dwarf",
  class: "Fighter",
  player: "Shin",
  level: 1,
  experience: 0,
};

export type UpdateTextFromOps = {
  property: keyof Pick<InfoSlice, "class" | "name" | "player" | "race">;
  value: string;
};

export const infoSlice = createSlice({
  name: "info",
  initialState,
  reducers: {
    updateTextFrom: (state, action: PayloadAction<UpdateTextFromOps>) => {
      state[action.payload.property] = action.payload.value;
    },

    updateLevel: (state, action: PayloadAction<number>) => {
      state.level = action.payload;

      const level = levelChart.find((l) => l.level === action.payload);

      if (level) {
        state.experience = level.experience;
      }
    },

    updateExperience: (state, action: PayloadAction<number>) => {
      state.experience = action.payload;

      const level = levelChart.find((l) => l.experience === action.payload);

      if (level) {
        state.level = level.level;
      }
    },
  },
});

export const { updateTextFrom, updateExperience, updateLevel } =
  infoSlice.actions;
