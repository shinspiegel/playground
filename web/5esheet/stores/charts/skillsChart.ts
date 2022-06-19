import { Skill } from "../slices/skillsSlice";

export type SkillChart = Pick<Skill, "name" | "short">;

export const skillChart: SkillChart[] = [
  { name: "Acrobatics", short: "DEX" },
  { name: "Animal Handling", short: "WIS" },
  { name: "Arcana", short: "INT" },
  { name: "Athletics", short: "STR" },
  { name: "Deception", short: "CHA" },
  { name: "History", short: "INT" },
  { name: "Insight", short: "WIS" },
  { name: "Intimidation", short: "CHA" },
  { name: "Investigation", short: "INT" },
  { name: "Medicine", short: "WIS" },
  { name: "Nature", short: "INT" },
  { name: "Perception", short: "WIS" },
  { name: "Performance", short: "CHA" },
  { name: "Persuasion", short: "CHA" },
  { name: "Religion", short: "INT" },
  { name: "Sleight of hand", short: "DEX" },
  { name: "Stealth", short: "DEX" },
  { name: "Survival", short: "WIS" },
];
