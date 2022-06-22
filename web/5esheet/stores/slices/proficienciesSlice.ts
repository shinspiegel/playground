import { createSlice, PayloadAction } from "@reduxjs/toolkit";

export type ProficiencyState = {
  list: Proficiency[];
};

export type Proficiency = {
  name: string;
  short?: string;
  profMultiplier?: number;
};

const initialState: ProficiencyState = {
  list: [],
};

export const proficienciesSlice = createSlice({
  name: "proficiencies",
  initialState,
  reducers: {
    addProf: (state, action: PayloadAction<Proficiency>) => {
      state.list.push(action.payload);
    },

    removeProfByName: (state, action: PayloadAction<string>) => {
      const filtered = [...state.list].filter((p) => p.name !== action.payload);
      state.list = filtered;
    },

    updateProf: (state, action: PayloadAction<Proficiency>) => {
      const prof = state.list.find((p) => p.name === action.payload.name);

      if (prof) {
        Object.assign(prof, { ...prof, ...action.payload });
      }
    },
  },
});

export const { addProf, removeProfByName, updateProf } = proficienciesSlice.actions;
