import { Character } from "./Character.ts";

export class SkillTester {
  constructor(public character = new Character()) {}

  testFor(amount = 10) {
    for (let i = 0; i < amount; i++) {
      this.character.roll();
    }
  }

  results(options?: (keyof Character)[]) {
    if (!options) options = ["name"];

    return this.character.showDetailsCsv(options);
  }
}
