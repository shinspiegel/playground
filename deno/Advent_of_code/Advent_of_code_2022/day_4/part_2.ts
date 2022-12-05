type Range = { min: number; max: number };

class Sector {
  private firstRange: Range;
  private secondRange: Range;

  constructor(entry: string) {
    const [first, second] = entry.split(",");

    this.firstRange = this.parseRange(first);
    this.secondRange = this.parseRange(second);
  }

  private parseRange(range: string): Range {
    const [min, max] = range.split("-");
    return {
      min: parseInt(min),
      max: parseInt(max),
    };
  }

  public hasIntersection(): boolean {
    if (this.firstRange.max < this.secondRange.min || this.firstRange.min > this.secondRange.max) {
      return false;
    }

    return true;
  }
}

export function partTwo(input: string[]) {
  let total = 0;

  input.forEach((entry) => {
    if (new Sector(entry).hasIntersection()) {
      total += 1;
    }
  });

  console.log(total);
}
