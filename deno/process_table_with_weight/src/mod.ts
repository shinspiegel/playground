import { generateTableData } from "./generateTableData.ts";
import { getColumnName } from "./getColumnName.ts";
import { getDice } from "./getDice.ts";
import { getFilePath } from "./getFilePath.ts";
import { parseInput } from "./parseInput.ts";
import { TableItem } from "./types.ts";
import { generateTableString } from "./generateTableString.ts";

try {
  const filePath = getFilePath();
  const tableColumn = getColumnName();
  const dice = getDice();

  const rawTable = await Deno.readTextFile(filePath);

  const parsed = parseInput(rawTable);
  const result: TableItem[] = generateTableData(parsed, dice);
  const resultString = generateTableString(result, dice, tableColumn);

  await Deno.writeTextFile(`${filePath}-output.md`, resultString);
} catch (err) {
  console.log("FAILED:: ", err?.message);
}
