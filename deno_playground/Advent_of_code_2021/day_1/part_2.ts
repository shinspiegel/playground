import { partOne } from "./part_1.ts";

type Measures = {
  id: number;
  value: number[];
  sum?: number;
};

export const partTwo = (data: number[]) => {
  const list: Measures[] = [];

  data.forEach((item, index) => {
    if (index === 1) {
      list[index - 1].value.push(item);
    }

    if (index > 1) {
      list[index - 2].value.push(item);
      list[index - 1].value.push(item);
    }

    list.push({ id: index, value: [item] });
  });

  const filtered = list
    .filter((d) => d.value.length === 3)
    .map((m) => ({ ...m, sum: m.value.reduce((p, c) => p + c) }));

  partOne(
    true,
    filtered.map((m) => m.sum)
  );
};
