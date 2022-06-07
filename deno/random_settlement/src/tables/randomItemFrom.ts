import { Table, TableOption } from "../types/index.ts";
import { randomIntFromInterval } from "../randomNumbers/randomIntFromInverval.ts";

type OptionWithValue = TableOption & { value: number };

type RandomItemFrom = { item: TableOption; random: number };

export function randomItemFrom(table: Table, random?: number): RandomItemFrom {
  const max = table.options.reduce((prev, curr) => curr.weight + prev, 0);
  let tableRandomValue = randomIntFromInterval({ max });
  const options: OptionWithValue[] = [];

  if (random && random < max) {
    tableRandomValue = random;
  }

  const sortedOptions = [...table.options].sort((a, b) => b.weight - a.weight);

  sortedOptions.forEach((item, i) => {
    if (i === 0) {
      options.push({ ...item, value: item.weight });
    } else {
      options.push({ ...item, value: item.weight + options[i - 1].value });
    }
  });

  const { value: _, ...item } = options.find(
    (item) => tableRandomValue <= item.value
  ) as OptionWithValue;

  return {
    item,
    random: tableRandomValue,
  };
}
