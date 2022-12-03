import { partOne } from "./part_1.ts";
import { partTwo } from "./part_2.ts";

const input = await Deno.readTextFile("input");
const data = input.split("\n");
partOne(data);
partTwo(data);
