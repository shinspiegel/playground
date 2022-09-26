import { Character } from "./Character.ts";
import { Dice } from "./Dice.ts";
import { SkillTester } from "./SkillTester.ts";

const resultOptions: (keyof Character)[] = ["name", "target", "skill", "succeedRatio"];
const csvStringRows = [resultOptions.join(",")];

for (let dice = 4; dice <= 12; dice += 2) {
  for (let target = 1; target <= 10; target++) {
    console.log(`INFO:: running for d${dice}::${target}`);

    let skill = Dice.d4;

    if (dice === 4) skill = Dice.d4;
    if (dice === 6) skill = Dice.d6;
    if (dice === 8) skill = Dice.d8;
    if (dice === 10) skill = Dice.d10;
    if (dice === 12) skill = Dice.d12;

    const tester = new SkillTester(
      new Character({
        name: `${target.toString().padStart(2, "0")}_d${dice.toString().padStart(2, "0")}`,
        target,
        skill,
      })
    );
    tester.testFor(1_000_000);
    csvStringRows.push(tester.results(resultOptions));
  }
}

await Deno.writeTextFile("./result.csv", csvStringRows.join("\n"));
