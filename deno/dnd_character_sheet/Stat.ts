export type StatConstructor = {
  id?: string;
  name?: string;
  value?: number;
};

export default class Stat {
  public id: string;
  public name: string;
  public value: number;
  public modifier: number;

  constructor({ id, name = "Unnamed", value = 10 }: StatConstructor) {
    this.name = name;
    this.value = value;

    if (id) {
      this.id = id;
    } else {
      this.id = this.name.substr(0, 3).toUpperCase().padStart(3, "_");
    }

    this.modifier = this.calculateModifier();
  }

  private calculateModifier() {
    return Math.floor((this.value - 10) / 2);
  }
}
