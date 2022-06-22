import { createSlice, PayloadAction } from "@reduxjs/toolkit";
import { levelChart } from "../charts";

export type InfoSlice = {
  name: string;
  race: string;
  dndClass: string;
  player: string;
  level: number;
  experience: number;
  proficiency: number;
};

const initialState: InfoSlice = {
  name: "Dwarfo",
  race: "Dwarf",
  dndClass: "Fighter",
  player: "Shin",
  level: 1,
  experience: 0,
  proficiency: 2,
};

export const infoSlice = createSlice({
  name: "info",
  initialState,
  reducers: {
    setName: (state, action: PayloadAction<string>) => {
      state.name = action.payload;
    },

    setRace: (state, action: PayloadAction<string>) => {
      state.race = action.payload;
    },

    setDndClass: (state, action: PayloadAction<string>) => {
      state.dndClass = action.payload;
    },

    setPlayer: (state, action: PayloadAction<string>) => {
      state.player = action.payload;
    },

    setLevel: (state, action: PayloadAction<number>) => {
      state.level = action.payload;

      const level = levelChart.find((l) => l.level === action.payload);

      if (level) {
        state.experience = level.experience;
        state.proficiency = level.prof;
      }
    },

    setExperience: (state, action: PayloadAction<number>) => {
      state.experience = action.payload;

      const level = levelChart.find((l) => l.experience === action.payload);

      if (level) {
        state.level = level.level;
        state.proficiency = level.prof;
      }
    },

    setProficiency: (state, action: PayloadAction<number>) => {
      state.proficiency = action.payload;
    },
  },
});
