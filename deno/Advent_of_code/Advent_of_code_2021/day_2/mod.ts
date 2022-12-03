const file = Deno.args[0];
if (!file) Deno.exit();

type Direction = "forward" | "down" | "up";
type Command = { direction: Direction; distance: number };
type Submarine = { horizontal: number; depth: number; aim: number };

const input = await Deno.readTextFile(file);
const data: Command[] = input.split("\n").map((i) => {
  const [direction, value] = i.split(" ");
  return { direction: direction as Direction, distance: parseInt(value) };
});

function calculateDistanceWithAim() {
  const submarine: Submarine = { aim: 0, horizontal: 0, depth: 0 };

  data.forEach((cmd) => {
    if (cmd.direction === "forward") {
      submarine.horizontal += cmd.distance;
      submarine.depth += cmd.distance * submarine.aim;
    }

    if (cmd.direction === "down") {
      submarine.aim += cmd.distance;
    }

    if (cmd.direction === "up") {
      submarine.aim -= cmd.distance;
    }
  });

  console.log(submarine.depth * submarine.horizontal);
}

function calculateDistance() {
  const submarine: Submarine = { aim: 0, horizontal: 0, depth: 0 };

  data.forEach((cmd) => {
    if (cmd.direction === "forward") {
      submarine.horizontal += cmd.distance;
    }

    if (cmd.direction === "down") {
      submarine.depth += cmd.distance;
    }

    if (cmd.direction === "up") {
      submarine.depth -= cmd.distance;
    }
  });

  console.log(submarine.depth * submarine.horizontal);
}

calculateDistance();
calculateDistanceWithAim();
