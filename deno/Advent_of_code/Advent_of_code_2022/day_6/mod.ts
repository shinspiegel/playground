import { partOne } from "./part_1.ts";

const input = await Deno.readTextFile("input");
const data = input.split("\n");
partOne(data, 4);
console.log("\n");
partOne(data, 14);
