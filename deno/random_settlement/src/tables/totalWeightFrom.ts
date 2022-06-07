import { Table } from "../types/index.ts";

export function totalWeightFrom(table: Table): number {
  return table.options.reduce((prev, curr) => prev + curr.weight, 0);
}
