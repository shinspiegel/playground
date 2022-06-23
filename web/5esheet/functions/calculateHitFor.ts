import { Stat } from "../stores";
import { parseDiceNotation } from "./parseDiceNotation";

type CalculateHitFor = {
  short: string;
  stats: Stat[];
  isProf?: boolean;
  profBonus: number;
};

export function calculateHitFor({ profBonus = 0, stats = [], short = "", isProf = false }: CalculateHitFor): string {
  const stat = stats.find((s) => s.short === short);

  let bonus = 0;

  if (stat) {
    bonus += stat.mod;
  }

  if (isProf) {
    bonus += profBonus;
  }

  return bonus >= 0 ? `+${bonus}` : `${bonus}`;
}
