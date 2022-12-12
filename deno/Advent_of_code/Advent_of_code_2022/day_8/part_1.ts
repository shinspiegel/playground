class VisibleTree {
  constructor(public height: number, public row: number, public column: number, public scenic: number = 0) {}
  public calculateScenic(up: number[], down: number[], left: number[], right: number[]) {
    this.scenic = up.length * down.length * left.length * right.length;
  }
}

export class Forest {
  public debug = false;
  public map: number[][];
  public visibleTrees: VisibleTree[] = [];
  public scenicValues: VisibleTree[] = [];

  constructor(input: string, debug = false) {
    this.map = this.parseMap(input);
    this.debug = debug;
    this.calculateVisibleTrees();
    this.calculateScenicScore();
  }

  private parseMap(input: string): number[][] {
    if (this.debug) console.log("Parsing: ", { input });
    return input.split("\n").map((line) => line.split("").map((char) => parseInt(char)));
  }

  private addVisibleTree(height: number, row: number, column: number): void {
    this.visibleTrees.push(new VisibleTree(height, row, column));
  }

  private isOnEdge(row: number, col: number): boolean {
    const firstRow = row === 0;
    const lastRow = row === this.map.length - 1;
    const firstCol = col === 0;
    const lastCol = col === this.map[row].length - 1;

    if (firstRow || lastRow || firstCol || lastCol) {
      if (this.debug) console.log("Edge found", { tree: this.map[row][row], row, col });
      return true;
    }

    return false;
  }

  private lineOfSight(tree: number, row: number, col: number): boolean {
    let isVisible = false;
    const up: number[] = [];
    const down: number[] = [];
    const left: number[] = [];
    const right: number[] = [];

    for (let i = 0; i < row; i++) {
      if (isVisible) break;
      up.push(this.map[i][col]);
    }

    if (Math.max(...up) < tree) isVisible = true;

    for (let i = row + 1; i < this.map.length; i++) {
      if (isVisible) break;
      down.push(this.map[i][col]);
    }

    if (Math.max(...down) < tree) isVisible = true;

    for (let i = 0; i < col; i++) {
      if (isVisible) break;
      left.push(this.map[row][i]);
    }

    if (Math.max(...left) < tree) isVisible = true;

    for (let i = col + 1; i < this.map[row].length; i++) {
      if (isVisible) break;
      right.push(this.map[row][i]);
    }

    if (Math.max(...right) < tree) isVisible = true;

    if (isVisible && this.debug) console.log("Found tree", { tree, row, col });

    return isVisible;
  }

  public calculateVisibleTrees() {
    for (let row = 0; row < this.map.length; row++) {
      for (let col = 0; col < this.map[row].length; col++) {
        if (this.debug) console.log("Process", { row, col });

        const tree = this.map[row][col];

        if (this.isOnEdge(row, col)) {
          this.addVisibleTree(tree, row, col);
          continue;
        }

        if (this.lineOfSight(tree, row, col)) {
          this.addVisibleTree(tree, row, col);
          continue;
        }
      }
    }
  }

  public calculateScenicScore() {
    for (let row = 0; row < this.map.length; row++) {
      for (let col = 0; col < this.map[row].length; col++) {
        if (this.isOnEdge(row, col)) continue;

        const tree = this.map[row][col];

        const up: number[] = [];
        const down: number[] = [];
        const left: number[] = [];
        const right: number[] = [];

        for (let i = row - 1; i >= 0; i--) {
          up.push(this.map[i][col]);
          if (this.map[i][col] >= tree) break;
        }

        for (let i = row + 1; i < this.map.length; i++) {
          down.push(this.map[i][col]);
          if (this.map[i][col] >= tree) break;
        }

        for (let i = col - 1; i >= 0; i--) {
          left.push(this.map[row][i]);
          if (this.map[row][i] >= tree) break;
        }

        for (let i = col + 1; i < this.map[row].length; i++) {
          right.push(this.map[row][i]);
          if (this.map[row][i] >= tree) break;
        }

        const visibleTree = new VisibleTree(tree, row, col);
        visibleTree.calculateScenic(up, down, left, right);
        this.scenicValues.push(visibleTree);
      }
    }

    this.scenicValues.sort((a, b) => b.scenic - a.scenic);
  }
}
