import { TableItem } from "./types.ts";

export function parseInput(
  input: string
): Pick<TableItem, "option" | "weight">[] {
  return input
    .split("\n")
    .map((r) => r.split("|"))
    .filter(([a, b]) => a || b)
    .map(([option, weight]) => ({
      option: option.trim(),
      weight: parseInt(weight.trim()),
    }))
    .sort((a, b) => b.weight - a.weight);
}
