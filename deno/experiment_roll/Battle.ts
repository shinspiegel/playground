import { Character } from "./Character.ts";

export class Battle {
  public tied = 0;
  public aScore = 0;
  public bScore = 0;

  constructor(public personA = new Character(), public personB = new Character()) {}

  showResults() {
    const total = this.tied + this.aScore + this.bScore;

    const aPercent = (this.aScore / total) * 100;
    const bPercent = (this.bScore / total) * 100;
    const tie = (this.tied / total) * 100;

    console.log(`
A::[%${aPercent.toFixed(1)}]
${this.personA.showDetails()}

B::[%${bPercent.toFixed(1)}]
${this.personB.showDetails()}

T::[%${tie.toFixed(1)}]
    `);
  }

  contestFor(rounds = 10) {
    for (let i = 0; i < rounds; i++) {
      this.contest();
    }
  }

  contest() {
    const a = this.personA.roll();

    if (a) {
      const b = this.personB.roll();

      if (b) {
        if (a > b) {
          this.aScore += 1;
        } else if (b > a) {
          this.bScore += 1;
        } else {
          this.tied += 1;
        }
      } else {
        this.aScore += 1;
      }
    } else {
      this.bScore += 1;
    }
  }
}
