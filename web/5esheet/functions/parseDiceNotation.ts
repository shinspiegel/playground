import { stringify } from "querystring";

export type ParseDiceNotation = {
  size: number;
  amount: number;
  bonus: number;
};

export function parseDiceNotation(dice: string): ParseDiceNotation {
  if (!dice.includes("d")) {
    throw new Error("Failed to parse the dice.");
  }

  const cleaned = dice.toLocaleLowerCase().trim().replace(/\s/g, "");
  const amount = Number(cleaned.split("d")[0]);
  const size = Number(cleaned.split("d")[1].split("+")[0]);
  const bonus = Number(cleaned.split("d")[1].split("+")[1]) || 0;

  if (isNaN(amount) || isNaN(size)) {
    throw new Error("Failed to parse the dice.");
  }

  return { size, amount, bonus };
}
