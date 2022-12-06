function decoder(entry: string, amount: number) {
  const set: string[] = [];

  for (let index = 0; index < entry.length; index++) {
    const letter = entry.at(index);
    if (!letter) throw new Error("Failed to read the string");

    set.push(letter);

    if (set.length === amount && isAllDifferent(set)) {
      return { letter, index: index + 1 };
    }

    if (set.length >= amount) {
      set.shift();
    }
  }

  throw new Error("Failed to locate");
}

function isAllDifferent(set: string[]): boolean {
  if ([...new Set(set)].length === set.length) {
    return true;
  }

  return false;
}

export function partOne(input: string[], amount: number) {
  input.forEach((i) => console.log(decoder(i, amount)));
}
