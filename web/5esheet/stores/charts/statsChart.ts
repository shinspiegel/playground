import { Stat } from "../slices";

export const statsChart: Stat[] = [
  {
    name: "Strength",
    short: "STR",
    value: 8,
    mod: -1,
    weight: 0,
    isProf: true,
  },
  { name: "Dexterity", short: "DEX", value: 10, mod: 0, weight: 1 },
  { name: "Constitution", short: "CON", value: 12, mod: 1, weight: 2 },
  { name: "Intelligence", short: "INT", value: 14, mod: 2, weight: 3 },
  { name: "Wisdom", short: "WIS", value: 16, mod: 3, weight: 4 },
  { name: "Charisma", short: "CHA", value: 18, mod: 4, weight: 5 },
];
