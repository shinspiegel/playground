class Elf {
  public total = 0;
  public list: number[] = [];

  addFood(input: number) {
    this.total += input;
    this.list.push(input);
  }
}

const elfList: Elf[] = [new Elf()];

export function partOne(text: string[]) {
  text.forEach((entry) => {
    if (entry === "") {
      elfList.push(new Elf());
      return;
    }

    elfList.at(-1)?.addFood(parseInt(entry));
  });

  elfList.sort((a, b) => b.total - a.total);

  console.log(elfList[0]);
}
