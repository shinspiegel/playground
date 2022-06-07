import {
  aasimar,
  dragonboen,
  dwarf,
  elf,
  genasi,
  gith,
  gnome,
  halfElf,
  halfOrc,
  halfling,
  human,
  races,
  shifter,
  tiefling,
  monstrous,
} from "../tables/racesTable.ts";
import { randomItemFrom } from "../tables/randomItemFrom.ts";

export function randomRace(): string {
  const allTables = [
    aasimar,
    dragonboen,
    dwarf,
    elf,
    genasi,
    gith,
    gnome,
    halfElf,
    halfOrc,
    halfling,
    human,
    races,
    shifter,
    tiefling,
    monstrous,
  ];

  const baseRace = randomItemFrom(races);
  const subRaceTable = allTables.find((t) => t.table === baseRace.item.option);

  let result = `[${baseRace.random}] - ${baseRace.item.option}`;

  if (subRaceTable) {
    const subRace = randomItemFrom(subRaceTable);

    result += ` (${subRace.item.option}) [${subRace.random}]`;
  }

  return result;
}
