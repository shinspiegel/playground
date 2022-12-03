function calculate(map: Map<string, boolean>): number {
  let total = 0;

  Array.from(map.keys()).forEach((letter) => {
    if (letter.toUpperCase() === letter) {
      total += letter.charCodeAt(0) - 38;
    } else {
      total += letter.charCodeAt(0) - 96;
    }
  });

  return total;
}

function generateMap(entries: string[]): Map<string, boolean> {
  if (entries.length !== 3) throw new Error("Wrong elven number!");

  const map = new Map<string, boolean>();

  [...entries[0]].forEach((letter) => {
    if (entries[1].includes(letter) && entries[2].includes(letter)) {
      map.set(letter, true);
    }
  });

  return map;
}

export function partTwo(input: string[]) {
  if (input.length % 3 !== 0) throw new Error("Elven ground invalid");

  let total = 0;

  const groups: string[][] = [];

  for (let i = 0; i < input.length; i += 3) {
    const list: string[] = [];
    list.push(input[i]);
    list.push(input[i + 1]);
    list.push(input[i + 2]);
    groups.push(list);
  }

  groups.forEach((group) => {
    total += calculate(generateMap(group));
  });

  console.log(total);
}
