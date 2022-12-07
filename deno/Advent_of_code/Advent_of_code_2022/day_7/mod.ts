import { FileSystem } from "./part_1.ts";

const input = await Deno.readTextFile("input");
const data = input.split("\n");

const dayOne = new FileSystem(data, { debug: false, print: false });
console.log(dayOne.solveOne(100000));

const dayTwo = new FileSystem(data, { debug: true, print: false });
console.log(
  dayTwo
    .solveTwo()
    .map((d) => d.totalSize)
    .sort((a, b) => a - b)
    .find((a) => dayTwo.unusedSpace + a > 30000000)
);
