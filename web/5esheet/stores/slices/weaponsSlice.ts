import { createSlice, PayloadAction } from "@reduxjs/toolkit";
import { statToMod } from "../../functions";
import { statsSlice } from "./statsSlice";

export type WeaponState = {
  list: Weapon[];
};

export type Weapon = {
  name: string;
  damageDice: string;
  short: string;
  bonus?: { hit?: number; damage?: number };
  range?: string;
  isProf?: boolean;
};

const initialState: WeaponState = {
  list: [
    {
      name: "Test1",
      damageDice: "1d6",
      short: "STR",
      range: "20ft./60ft.",
      bonus: { hit: 3, damage: 3 },
      isProf: true,
    },
    {
      name: "Test2",
      damageDice: "2d6",
      short: "DEX",
      range: "80ft./120ft.",
      bonus: { hit: 3, damage: 3 },
      isProf: false,
    },
  ],
};

export const weaponSlice = createSlice({
  name: "weapon",
  initialState,
  reducers: {
    add: (state, action: PayloadAction<Weapon>) => {
      state.list.push(action.payload);
    },

    update: (state, action: PayloadAction<Weapon>) => {
      let weapon = state.list.find((w) => w.name === action.payload.name);
      weapon = { ...weapon, ...action.payload };
    },

    removeByName: (state, action: PayloadAction<string>) => {
      const filtered = [...state.list].filter((w) => w.name !== action.payload);
      state.list = filtered;
    },
  },
});
