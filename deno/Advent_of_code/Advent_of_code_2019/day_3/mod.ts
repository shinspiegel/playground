const input: string = await Deno.readTextFile("sample");
const data: string[] = input.split("\n");

type Point2D = { x: number; y: number };
type ManhattanCode = { direction: string; amount: number };

function start(input: string[]) {
  const lines = input.map((line) => line.split(",").map(generateManhattanCode));
  // const lineMoves = lines.map((line) => moveSequence(line));

  moveSequence(lines[0]);

  // console.log("lines?", lineMoves);
}

function moveSequence(manhattanCodes: ManhattanCode[]) {
  const result: Point2D = { x: 10, y: 0 };
  const movesList: Point2D[] = [{ ...result }];

  console.log(manhattanCodes[0]);

  for (let i = result.x; i <= manhattanCodes[0].amount + result.x; i++) {
    result.x = i;
    movesList.push({ ...result });
  }

  console.log(movesList);

  return movesList;
}

function generateManhattanCode(point: string): ManhattanCode {
  const array = [...point];
  const direction = array.shift() || "";
  const amount = Number(array.join(""));

  return { direction, amount };
}

start(data);
