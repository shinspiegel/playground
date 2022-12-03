const input = await Deno.readTextFile("input");
const data = input.split("");

let floor = 0;
let first: number | undefined = undefined;

for (let i = 0; i < data.length; i++) {
  const element = data[i];

  if (element === "(") floor += 1;
  if (element === ")") floor -= 1;

  if (floor === -1 && !first) {
    first = i + 1;
  }
}

console.log(floor, first);
