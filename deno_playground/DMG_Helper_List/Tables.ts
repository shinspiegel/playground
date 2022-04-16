import { random } from "./RandomNumbers.ts";

type tableData<T> = { data: T; range: number; accumulated: number };
type simpleTable = string;
type tavernName = { first: string; second: string };
type npcName = { first: string; second: string; third: string };
type buildingType = { type: string; description: string };

function parserTable<T>(filePath: string) {
  const rawData = Deno.readTextFileSync(filePath);
  const jsonData: { data: T; range?: number }[] = JSON.parse(rawData);
  const cleaned: tableData<T>[] = [];

  for (let i = 0; i < jsonData.length; i++) {
    const data = jsonData[i].data;
    const range = jsonData[i].range || 1;
    const accumulated = cleaned.reduce((acc, curr) => acc + curr.range, 0) + range;

    cleaned.push({
      data,
      range,
      accumulated,
    });
  }

  return cleaned;
}

export function randomFrom<T>(table: tableData<T>[]) {
  return function () {
    const value = random(table.reduce((acc, cur) => acc + cur.range, 0));

    for (let i = 0; i < table.length; i++) {
      if (value < table[i].accumulated) {
        return table[i];
      }
    }

    throw new Error("TABLES:: Failed to recover");
  };
}

export const pickRandom = {
  Name: randomFrom<simpleTable>(parserTable("assets/names/names.json")),
  TavernName: randomFrom<tavernName>(parserTable("assets/names/tavernName.json")),
  NpcName: randomFrom<npcName>(parserTable("assets/names/npcName.json")),

  RaceRelation: randomFrom<simpleTable>(parserTable("assets/settlement/raceRelations.json")),
  RulerStatus: randomFrom<simpleTable>(parserTable("assets/settlement/rulerStatus.json")),
  NotableTraits: randomFrom<simpleTable>(parserTable("assets/settlement/notableTraits.json")),
  KnowForIts: randomFrom<simpleTable>(parserTable("assets/settlement/knowForIts.json")),
  CurrentCalamity: randomFrom<simpleTable>(parserTable("assets/settlement/currentCalamity.json")),
  BuildingType: randomFrom<buildingType>(parserTable("assets/building/BuildingType.json")),
  ReligiousBuilding: randomFrom<simpleTable>(parserTable("assets/building/ReligiousBuilding.json")),
  Residence: randomFrom<simpleTable>(parserTable("assets/building/Residence.json")),
  Shop: randomFrom<simpleTable>(parserTable("assets/building/Shop.json")),
  Tavern: randomFrom<simpleTable>(parserTable("assets/building/Tavern.json")),
  Warehouse: randomFrom<simpleTable>(parserTable("assets/building/Warehouse.json")),

  Appearance: randomFrom<simpleTable>(parserTable("assets/npc/Appearance.json")),
  Bonds: randomFrom<simpleTable>(parserTable("assets/npc/Bonds.json")),
  ChaoticIdeals: randomFrom<simpleTable>(parserTable("assets/npc/ChaoticIdeals.json")),
  EvilIdeals: randomFrom<simpleTable>(parserTable("assets/npc/EvilIdeals.json")),
  FlawsAndSecrets: randomFrom<simpleTable>(parserTable("assets/npc/FlawsAndSecrets.json")),
  GoodIdeals: randomFrom<simpleTable>(parserTable("assets/npc/GoodIdeals.json")),
  Hability: randomFrom<simpleTable>(parserTable("assets/npc/Hability.json")),
  Interaction: randomFrom<simpleTable>(parserTable("assets/npc/Interaction.json")),
  LawfulIdeals: randomFrom<simpleTable>(parserTable("assets/npc/LawfulIdeals.json")),
  Mannerisms: randomFrom<simpleTable>(parserTable("assets/npc/Mannerisms.json")),
  OtherIdeals: randomFrom<simpleTable>(parserTable("assets/npc/OtherIdeals.json")),
  Talent: randomFrom<simpleTable>(parserTable("assets/npc/Talent.json")),
};
