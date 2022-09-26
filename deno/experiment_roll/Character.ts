import { Dice } from "./Dice.ts";

export class Character {
  public target: number;
  public skill: () => number;
  public succeed: number;
  public failed: number;

  constructor({
    target = 10,
    skill = Dice.d10,
    succeed = 0,
    failed = 0,
  }: {
    target?: number;
    skill?: () => number;
    succeed?: number;
    failed?: number;
  } = {}) {
    this.target = target;
    this.skill = skill;
    this.succeed = succeed;
    this.failed = failed;
  }

  showDetails() {
    const total = this.succeed + this.failed;
    const succeedRatio = (this.succeed / total) * 100;

    return `Dice/Target  ::[${this.skill.name}/${this.target}]
Succeed ratio::[%${succeedRatio.toFixed(1)}]`;
  }

  roll(): number | undefined {
    const rollVal = this.skill();

    if (rollVal <= this.target) {
      this.succeed += 1;
      return rollVal;
    } else {
      this.failed += 1;
      return;
    }
  }
}
