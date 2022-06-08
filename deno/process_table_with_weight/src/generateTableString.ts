import { TableItem } from "./types.ts";

export function generateTableString(
  data: TableItem[],
  dice: number,
  tableColumn: string
) {
  return data
    .map((r, i) => {
      let result = "";

      if (i === 0) {
        result += `|dice: 1d${dice}|${tableColumn}|`;
        result += `\n`;
        result += `|:--:|:--|`;
        result += `\n`;
      }

      result += `|${r.roll}|${r.option}|`;
      result += `\n`;

      return result;
    })
    .join("");
}
