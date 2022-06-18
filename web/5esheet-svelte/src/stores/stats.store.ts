import { writable } from "svelte/store";
import { sortByWeight } from "../functions/sortByWeight";

export type Stat = {
  weight: number;
  name: string;
  short: string;
  value: number;
  mod: number;
};

const data: Stat[] = [
  { weight: 0, name: "Strength", short: "STR", value: 8, mod: -1 },
  { weight: 1, name: "Dexterity", short: "DEX", value: 10, mod: 0 },
  { weight: 2, name: "Constitution", short: "CON", value: 12, mod: 1 },
  { weight: 3, name: "Intelligence", short: "INT", value: 14, mod: 2 },
  { weight: 4, name: "Wisdom", short: "WIS", value: 16, mod: 3 },
  { weight: 5, name: "Charisma", short: "CHA", value: 18, mod: 4 }
];

export const statsStore = writable<Stat[]>(data.sort(sortByWeight));
