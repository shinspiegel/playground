import { Forest } from "./part_1.ts";

const input = await Deno.readTextFile("input");

const forest = new Forest(input);
// console.log(forest);
// console.log(forest.visibleTrees.length);
console.log(forest.scenicValues[0].scenic);
