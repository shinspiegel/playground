import { pickRandom } from "./Tables.ts";
import { randomName } from "./Names.ts";
import { randomRange } from "./RandomNumbers.ts";
import { randomStats, Stats } from "./Stats.ts";

export interface Npc {
  name: string;
  familyName: string;
  alignment: string;
  appearance: string;
  bond: string;
  flawsAndSecrets: string;
  stats: Stats;
}

export function randomNPC() {
  const npc = {} as Npc;

  npc.name = randomName();
  npc.familyName = randomName();
  npc.alignment = randomAlignment();
  npc.appearance = pickRandom.Appearance().data;
  npc.bond = pickRandom.Bonds().data;
  npc.flawsAndSecrets = pickRandom.FlawsAndSecrets().data;
  npc.stats = randomStats();

  return npc;
}

function randomAlignment() {
  const goodAxisIndex = randomRange(0, 2);
  const lawfulAxisIndex = randomRange(0, 2);
  const goodAxisOptions = ["Good", "Neutral", "Evil"];
  const lawfulAxisOptions = ["Lawful", "Neutral", "Chaotic"];

  if (goodAxisIndex === 1 && lawfulAxisIndex === 1) {
    return "True Neutral";
  }

  return `${lawfulAxisOptions[lawfulAxisIndex]} ${goodAxisOptions[goodAxisIndex]}`;
}
