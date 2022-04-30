import { pickRandom } from "./Tables.ts";

export function randomName() {
  const { NpcName } = pickRandom;
  return `${NpcName().data.first}${NpcName().data.second}${NpcName().data.third}`.trim();
}
