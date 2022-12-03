class Backpack {
  public value = 0;
  private left: string;
  private right: string;

  constructor(entry: string) {
    if (entry.length % 2 !== 0) throw new Error("Invalid");

    const half = entry.length / 2;

    this.left = entry.substring(0, half);
    this.right = entry.substring(half, entry.length);

    const map = new Map<string, boolean>();

    [...this.left].forEach((letter) => {
      if (this.right.includes(letter)) {
        map.set(letter, true);
      }
    });

    Array.from(map.keys()).forEach((letter) => {
      if (letter.toUpperCase() === letter) {
        this.value += letter.charCodeAt(0) - 38;
      } else {
        this.value += letter.charCodeAt(0) - 96;
      }
    });
  }
}

export function partOne(input: string[]) {
  let total = 0;

  input.forEach((entry) => {
    const bp = new Backpack(entry);
    total += bp.value;
  });

  console.log(total);
}
