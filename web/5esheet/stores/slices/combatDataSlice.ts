import { createSlice, PayloadAction } from "@reduxjs/toolkit";
import { statToMod } from "../../functions";
import { statsSlice } from "./statsSlice";

export type CombatDataState = {
  maxHp: number;
  currentHp: number;
  tempHp: number;
  hitDices: string;
  speed: string;
  initiative: number;
  deathSaving: DeathSaving;
};

export type DeathSaving = {
  success: number;
  fail: number;
};

export type SetPropertyOpt = {
  property: keyof CombatDataState;
  value: number | string;
};

const initialState: CombatDataState = {
  maxHp: 10,
  currentHp: 5,
  tempHp: 3,
  hitDices: "1d10",
  speed: "30ft.",
  initiative: 2,
  deathSaving: {
    success: 1,
    fail: 2,
  },
};

export const combatDataSlice = createSlice({
  name: "combatData",
  initialState,
  reducers: {
    setMaxHp: (state, action: PayloadAction<number>) => {
      state.maxHp = action.payload;

      if (state.currentHp > action.payload) {
        state.currentHp = action.payload;
      }
    },

    setCurrentHp: (state, action: PayloadAction<number>) => {
      let hitPoints = action.payload;

      if (hitPoints > state.maxHp) {
        hitPoints = state.maxHp;
      }

      if (hitPoints < 0) {
        hitPoints = 0;
      }

      state.currentHp = hitPoints;
    },

    setTempHp: (state, action: PayloadAction<number>) => {
      state.tempHp = action.payload;
    },

    setHitDices: (state, action: PayloadAction<string>) => {
      state.hitDices = action.payload;
    },

    setSpeed: (state, action: PayloadAction<string>) => {
      state.speed = action.payload;
    },

    setInitiative: (state, action: PayloadAction<number>) => {
      state.initiative = action.payload;
    },

    setDeathSaving: (state, action: PayloadAction<DeathSaving>) => {
      state.deathSaving = action.payload;
    },
  },

  extraReducers: (builder) => {
    builder
      .addCase(statsSlice.actions.changeValueFor, (state, action) => {
        if (action.payload.name === "Dexterity") {
          const statMod = statToMod(action.payload.value);
          state.initiative = statMod;
        }
      })
      .addCase(statsSlice.actions.changeModFor, (state, action) => {
        if (action.payload.name === "Dexterity") {
          const statMod = action.payload.value;
          state.initiative = statMod;
        }
      });
  },
});
