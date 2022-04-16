enum OperationType {
  add = "+",
  multiply = "*",
}

class IntCode {
  private data: number[] = [];
  private step = 0;
  private head = 0;
  public debug = false;

  constructor(private dataString: string, noum = 0, verb = 0) {
    this.data = this.dataString.split(",").map((s) => Number(s));
    this.data[1] = noum;
    this.data[2] = verb;
  }

  public start(value = 0): number {
    this.head = value;
    return this.execute();
  }

  public toggleDebug() {
    this.debug = !this.debug;
    return this;
  }

  public showData() {
    console.log(this.data.join(","));
  }

  private execute(): number {
    this.step += 1;

    switch (this.data[this.head]) {
      case 1:
        this.mathOperation(OperationType.add);
        break;

      case 2:
        this.mathOperation(OperationType.multiply);
        break;

      default:
        return this.halt();
    }

    return this.execute();
  }

  private log(obj: unknown = {}) {
    if (this.debug) {
      console.log(
        `[${String(this.step).padStart(4, "0")}]:: HEAD[${String(
          this.head
        ).padStart(3, "0")}] COMMAND[${
          this.data[this.head]
        }] - ${JSON.stringify(obj)}`
      );
    }
  }

  private halt(value = 0) {
    const result = this.data[value];

    if (this.debug) {
      console.log("Completed, halted with position 0 with: ", result);
    }

    return result;
  }

  private mathOperation(type: OperationType) {
    const firstIndex = this.data[this.head + 1];
    const secondIndex = this.data[this.head + 2];
    const resultIndex = this.data[this.head + 3];
    let result = 0;

    switch (type) {
      case OperationType.add:
        result = this.data[firstIndex] + this.data[secondIndex];
        break;

      case OperationType.multiply:
        result = this.data[firstIndex] * this.data[secondIndex];
        break;
    }

    this.data[resultIndex] = result;
    this.log({ firstIndex, secondIndex, result });
    this.moveHead();
  }

  private moveHead(value = 4) {
    this.head = this.head + value;
  }
}

export default IntCode;
