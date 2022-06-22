import { createSlice, PayloadAction } from "@reduxjs/toolkit";
import { levelChart } from "../charts";

export type InfoSlice = {
  name: string;
  race: string;
  class: string;
  player: string;
  level: number;
  experience: number;
  proficiency: number;
};

export type UpdateTextFromOps = {
  property: keyof Pick<InfoSlice, "class" | "name" | "player" | "race">;
  value: string;
};

const initialState: InfoSlice = {
  name: "Dwarfo",
  race: "Dwarf",
  class: "Fighter",
  player: "Shin",
  level: 1,
  experience: 0,
  proficiency: 2,
};

export const infoSlice = createSlice({
  name: "info",
  initialState,
  reducers: {
    updateTextFrom: (state, action: PayloadAction<UpdateTextFromOps>) => {
      state[action.payload.property] = action.payload.value;
    },

    updateProfBonus: (state, action: PayloadAction<number>) => {
      state.proficiency = action.payload;
    },

    updateLevel: (state, action: PayloadAction<number>) => {
      state.level = action.payload;

      const level = levelChart.find((l) => l.level === action.payload);

      if (level) {
        state.experience = level.experience;
        state.proficiency = level.prof;
      }
    },

    updateExperience: (state, action: PayloadAction<number>) => {
      state.experience = action.payload;

      const level = levelChart.find((l) => l.experience === action.payload);

      if (level) {
        state.level = level.level;
        state.proficiency = level.prof;
      }
    },
  },
});

export const { updateTextFrom, updateExperience, updateLevel, updateProfBonus } = infoSlice.actions;
