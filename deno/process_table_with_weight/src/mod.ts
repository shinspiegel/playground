type TableItem = { option: string; weight: number; roll: string };

function getFilePath() {
  const arg = Deno.args[0];

  if (arg) {
    return arg;
  } else {
    throw new Error("No file specified");
  }
}

function getColumnName() {
  const arg = Deno.args[1];

  if (arg) {
    return arg;
  } else {
    console.warn("The second argument is the column name.");
    return "Column";
  }
}

function getDice() {
  const arg = Deno.args[2];

  if (arg) {
    return arg;
  } else {
    console.warn("The third argument is the dice. E.g.: '1d100'");
    return "1d6";
  }
}

try {
  const filePath = getFilePath();
  const tableColumn = getColumnName();
  const dice = getDice();

  const rawTable = await Deno.readTextFile(filePath);

  const parsed: Pick<TableItem, "option" | "weight">[] = rawTable
    .split("\n")
    .map((r) => r.split("|"))
    .map(([option, weight]) => ({
      option: option.trim(),
      weight: parseInt(weight.trim()),
    }));

  const sorted = parsed.sort((a, b) => b.weight - a.weight);

  const result: TableItem[] = [];

  sorted.forEach((item, index) => {
    if (index === 0) {
      const roll = item.weight !== 1 ? `1-${item.weight}` : "1";
      result.push({ ...item, roll });
      return;
    }

    const rollMin = result.reduce((prev, curr) => prev + curr.weight, 0);
    const roll = item.weight !== 1 ? `${rollMin + 1}-${item.weight + rollMin}` : `${rollMin + 1}`;
    result.push({ ...item, roll });
  });

  const resultString = result
    .map((r, i) => {
      let result = "";

      if (i === 0) {
        result += `|dice: ${dice}|${tableColumn}|`;
        result += `\n`;
        result += `|:--:|:--|`;
        result += `\n`;
      }

      result += `|${r.roll}|${r.option}|`;
      result += `\n`;

      return result;
    })
    .join("");

  await Deno.writeTextFile(`${filePath}-output.md`, resultString);
} catch (err) {
  console.log("FAILED:: ", err.message);
}
