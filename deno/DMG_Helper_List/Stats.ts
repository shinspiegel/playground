import { randomRange, randomStat } from "./RandomNumbers.ts";

export interface Stats {
  str: number;
  des: number;
  con: number;
  int: number;
  wis: number;
  cha: number;
}

export function randomStats() {
  const stat = {} as Stats;

  stat.str = randomStat();
  stat.des = randomStat();
  stat.con = randomStat();
  stat.int = randomStat();
  stat.wis = randomStat();
  stat.cha = randomStat();

  return stat;
}
