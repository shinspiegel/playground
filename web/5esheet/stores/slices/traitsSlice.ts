import { createSlice, PayloadAction } from "@reduxjs/toolkit";

export type TraitsState = {
  list: Trait[];
};

export type Trait = {
  name: string;
  description: string;
};

const initialState: TraitsState = {
  list: [
    {
      name: "Trait one",
      description: "Description one",
    },
  ],
};

export const traitsSlice = createSlice({
  name: "traits",
  initialState,
  reducers: {
    add: (state, action: PayloadAction<Trait>) => {
      state.list.push(action.payload);
    },

    update: (state, action: PayloadAction<Trait>) => {
      let weapon = state.list.find((w) => w.name === action.payload.name);
      weapon = { ...weapon, ...action.payload };
    },

    removeByName: (state, action: PayloadAction<string>) => {
      const filtered = [...state.list].filter((w) => w.name !== action.payload);
      state.list = filtered;
    },
  },
});
