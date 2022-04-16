const input: MapArea = await Deno.readTextFile("day_9/input")
  .then((file) => file.split("\n"))
  .then((lines) => lines.map((line) => line.split("").map((i) => parseInt(i))));

type Vector2D = { X: number; Y: number };
type MapArea = number[][];

function getValueFromPos(map: MapArea, { X, Y }: Vector2D) {
  const maxY = map.length - 1;
  const maxX = map[0].length - 1;

  if (X > maxX || Y > maxY || X < 0 || Y < 0) {
    return undefined;
  }

  return map[Y][X];
}

function getLowestPositions(map: MapArea): Vector2D[] {
  const position: Vector2D[] = [];

  map.forEach((yLine, Y) => {
    yLine.forEach((value, X) => {
      const top = getValueFromPos(map, { X, Y: Y - 1 }) ?? Infinity;
      const bottom = getValueFromPos(map, { X, Y: Y + 1 }) ?? Infinity;
      const left = getValueFromPos(map, { X: X - 1, Y }) ?? Infinity;
      const right = getValueFromPos(map, { X: X + 1, Y }) ?? Infinity;

      if (value < top && value < bottom && value < left && value < right) {
        position.push({ Y, X });
      }
    });
  });

  return position;
}

function calculateRiskFor(map: MapArea, positionList: Vector2D[]) {
  return positionList.map(({ X, Y }) => {
    return (getValueFromPos(map, { X, Y }) ?? 0) + 1;
  });
}

console.log(
  calculateRiskFor(input, getLowestPositions(input)).reduce((p, c) => p + c, 0)
);
