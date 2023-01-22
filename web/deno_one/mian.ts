import { DateTime } from "npm:luxon";

const a = new Date("2021-01-29");
const b = DateTime.fromString("2021-01-29");

console.log("AAAQAAAAAAA");
console.log(a.toString());
console.log(b.toString());
