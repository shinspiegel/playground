import { raceRelation } from "./tables/tables.ts";
import { randomItemFrom } from "./tables/randomItemFrom.ts";

console.log(randomItemFrom(raceRelation, 5));
