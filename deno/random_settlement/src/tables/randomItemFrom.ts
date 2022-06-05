import { Table, TableOption } from "../types/index.ts";
import { randomIntFromInterval } from "../randomNumbers/randomIntFromInverval.ts";

type OptionWithValue = TableOption & { value: number };

export function randomItemFrom(table: Table, value: number): TableOption {
  const max = table.options.reduce((prev, curr) => curr.weight + prev, 0);
  const options: OptionWithValue[] = [];

  if (value > max) {
    value = randomIntFromInterval({ max });
  }

  const sortedOptions = [...table.options].sort((a, b) => b.weight - a.weight);

  sortedOptions.forEach((item, i) => {
    if (i === 0) {
      options.push({ ...item, value: item.weight });
    } else {
      options.push({ ...item, value: item.weight + options[i - 1].value });
    }
  });

  const { value: _, ...item } = options.find((item) => value <= item.value) as OptionWithValue;

  return item;
}
