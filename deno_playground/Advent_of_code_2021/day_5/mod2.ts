import * as path from "https://deno.land/std@0.117.0/path/mod.ts";

const input = await Deno.readTextFile(path.join("day_5", "input"));
const rows = input.split("\n").filter(Boolean);

const coords = rows.map((row) =>
  row.split(" -> ").map((pos) => pos.split(",").map((n) => Number(n)))
);

const handleStraightLines = () => {
  const straightLines = coords.filter(
    ([x, y]) => x[0] === y[0] || x[1] === y[1]
  );

  const generateStraightLineCoords = (row: Array<Array<number>>) => {
    const [x, y] = row;
    const hits: Array<string> = [];
    if (x[0] === y[0]) {
      const [start, end] = [x[1], y[1]].sort((a, b) => a - b);
      for (let i = start; i < end + 1; i++) {
        hits.push(`${x[0]}-${i}`);
      }
    } else {
      const [start, end] = [x[0], y[0]].sort((a, b) => a - b);
      for (let i = start; i < end + 1; i++) {
        hits.push(`${i}-${y[1]}`);
      }
    }

    return hits;
  };

  const straightCoords = straightLines.map((line) =>
    generateStraightLineCoords(line)
  );
  return straightCoords.flat();
};

const handleDiagonals = () => {
  const diagonals = coords.filter(([x, y]) => x[0] !== y[0] && x[1] !== y[1]);

  const generateDiagonalCoords = (row: Array<Array<number>>) => {
    const [x, y] = row;

    const foundCoords: Array<string> = [`${x[0]}-${x[1]}`];

    let curr = [...x];
    while (curr[0] !== y[0] && curr[1] !== y[1]) {
      let newX = curr[0];
      let newY = curr[1];

      if (newX !== y[0]) newX = newX + (newX > y[0] ? -1 : 1);
      if (newY !== y[1]) newY = newY + (newY > y[1] ? -1 : 1);

      foundCoords.push(`${newX}-${newY}`);
      curr = [newX, newY];
    }
    return foundCoords;
  };
  return diagonals.map((line) => generateDiagonalCoords(line)).flat();
};

const allCoords = [...handleStraightLines(), ...handleDiagonals()];

const seen: Array<{ id: string; count: number }> = [];

allCoords.flat().map((coord) => {
  const seenIndex = seen.findIndex(({ id }) => id === coord);
  if (seenIndex >= 0) {
    seen[seenIndex].count += 1;
  } else {
    seen.push({ id: coord, count: 1 });
  }
});

const duplicates = seen.filter(({ count }) => count > 1);

console.log(duplicates.length);
