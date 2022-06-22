import { createSlice, PayloadAction } from "@reduxjs/toolkit";
import { skillChart } from "../charts";

export type SkillsState = {
  list: Skill[];
};

export type Skill = {
  name: string;
  short: string;
  profMultiplier: number;
};

type ChangeSkillProf = { name: string; value: number };

const initialState: SkillsState = {
  list: skillChart.map((s) => ({ ...s, profMultiplier: 0 })),
};

export const skillsSlice = createSlice({
  name: "skills",
  initialState,
  reducers: {
    changeSkillProf: (state, action: PayloadAction<ChangeSkillProf>) => {
      const skill = state.list.find((s) => s.name === action.payload.name);

      if (skill) {
        skill.profMultiplier = action.payload.value;
      }
    },
  },
});

