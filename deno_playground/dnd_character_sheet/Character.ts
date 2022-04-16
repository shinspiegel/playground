import Stat from "./Stat.ts";

export default class Character {
  constructor(
    public stats: Stat[] = [
      new Stat({ name: "Strength", value: 12 }),
      new Stat({ name: "Dexterity", value: 13 }),
      new Stat({ name: "Constitution", value: 16 }),
      new Stat({ name: "Intelligence", value: 17 }),
      new Stat({ name: "Wisdom", value: 20 }),
      new Stat({ name: "Charisma", value: 8 }),
    ]
  ) {}
}
