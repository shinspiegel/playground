import { Dice } from "./Dice.ts";

type CharacterKeys = keyof Character;

export class Character {
  public name: string;
  public target: number;
  public skill: () => number;
  public succeed: number;
  public failed: number;

  constructor({
    name,
    target = 10,
    skill = Dice.d10,
    succeed = 0,
    failed = 0,
  }: {
    name?: string;
    target?: number;
    skill?: () => number;
    succeed?: number;
    failed?: number;
  } = {}) {
    if (name) {
      this.name = name;
    } else {
      this.name = `${target}_${skill.name}`;
    }

    this.target = target;
    this.skill = skill;
    this.succeed = succeed;
    this.failed = failed;
  }

  get total() {
    return this.succeed + this.failed;
  }

  get succeedRatio() {
    return (this.succeed / this.total) * 100;
  }

  showDetails() {
    const total = this.succeed + this.failed;
    const succeedRatio = (this.succeed / total) * 100;

    return `Dice/Target  ::[${this.skill.name}/${this.target}]
Succeed ratio::[%${succeedRatio.toFixed(1)}]`;
  }

  showDetailsCsv(options: (keyof Character)[] = []) {
    const resultArray = options.map((key) => {
      const property = this[key];

      switch (typeof property) {
        case "function":
          return property.name;
        case "number":
          return property.toFixed(1);
        default:
          return property;
      }
    });

    return resultArray.join(",");
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
