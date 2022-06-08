import { TableItem } from "./types.ts";

export function generateTableData(
  parsed: Pick<TableItem, "option" | "weight">[],
  max?: number
) {
  const result: TableItem[] = [];
  const tableMax = parsed.reduce((prev, curr) => prev + curr.weight, 0);

  if (max && tableMax !== max) {
    throw new Error(
      `Table contains total of ${tableMax} options. Does not fit dice of 1d${max}`
    );
  }

  parsed.forEach((item, index) => {
    if (index === 0) {
      const roll = item.weight !== 1 ? `1-${item.weight}` : "1";
      result.push({ ...item, roll });
      return;
    }

    const rollMin = result.reduce((prev, curr) => prev + curr.weight, 0);
    const roll =
      item.weight !== 1
        ? `${rollMin + 1}-${item.weight + rollMin}`
        : `${rollMin + 1}`;
    result.push({ ...item, roll });
  });

  return result;
}
