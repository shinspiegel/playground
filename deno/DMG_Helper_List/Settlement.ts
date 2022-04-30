import { pickRandom } from "./Tables.ts";
import { randomRange } from "./RandomNumbers.ts";
import { Building, randomBuilding } from "./Building.ts";
import { randomName } from "./Names.ts";

export interface Settlement {
  name: string;
  raceRelation: string;
  rulerStatus: string;
  notableTrait: string;
  knowForIts: string;
  currentCalamity: string;
  buildings: Building[];
}

export function randomSettlement() {
  const settlement = {} as Settlement;

  settlement.name = randomName();
  settlement.raceRelation = pickRandom.RaceRelation().data;
  settlement.rulerStatus = pickRandom.RulerStatus().data;
  settlement.notableTrait = pickRandom.NotableTraits().data;
  settlement.knowForIts = pickRandom.KnowForIts().data;
  settlement.currentCalamity = pickRandom.CurrentCalamity().data;
  settlement.buildings = [];

  for (let i = 0; i < randomRange(0, 20); i++) {
    settlement.buildings.push(randomBuilding());
  }

  return settlement;
}
