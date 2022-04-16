const input: string = await Deno.readTextFile("input");

import IntCode from "./IntCode.ts";

const target = 19690720;

for (let noum = 0; noum <= 99; noum++) {
  for (let verb = 0; verb < 99; verb++) {
    const result = new IntCode(input, noum, verb).start();
    if (result === target) {
      console.log("Found!", result, noum, verb, 100 * noum + verb);
    }
  }
}
