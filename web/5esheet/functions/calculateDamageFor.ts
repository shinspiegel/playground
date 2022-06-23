import { Stat } from "../stores";
import { parseDiceNotation } from "./parseDiceNotation";

type CalculateDamageForOpt = {
  damageDice: string;
  short: string;
  stats: Stat[];
};

export function calculateDamageFor({ damageDice = "", short = "", stats = [] }: CalculateDamageForOpt): string {
  const stat = stats.find((s) => s.short === short);
  let { amount, bonus, size } = parseDiceNotation(damageDice);
  let damageNotation = `${amount}d${size}`;

  if (stat) {
    bonus += stat.mod;
  }

  if (bonus !== 0) {
    if (bonus > 0) {
      damageNotation += `+${bonus}`;
    } else {
      damageNotation += `${bonus}`;
    }
  }

  return damageNotation;
}
