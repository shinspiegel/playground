class Elf {
  public total = 0;
  public list: number[] = [];

  addFood(input: number) {
    this.total += input;
    this.list.push(input);
  }
}

const elfList: Elf[] = [new Elf()];

export function partTwo(text: string[]) {
  text.forEach((entry) => {
    if (entry === "") {
      elfList.push(new Elf());
      return;
    }

    elfList.at(-1)?.addFood(parseInt(entry));
  });

  elfList.sort((a, b) => b.total - a.total);

  console.log(elfList[0].total + elfList[1].total + elfList[2].total);
  console.log(elfList[0]);
  console.log(elfList[1]);
  console.log(elfList[2]);
}
