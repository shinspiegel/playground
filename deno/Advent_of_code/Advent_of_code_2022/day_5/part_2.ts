type Lane = { id: number; crates: string[] };
type Command = { amount: number; origin: number; destination: number };

const awaiter = (time: number) =>
  new Promise<void>((res) => {
    setTimeout(() => {
      res();
    }, time);
  });

class Crane {
  private lanes: Lane[] = [];
  private commands: Command[] = [];
  public delay = 50;
  public showOutPut = false;

  constructor(input: string[]) {
    const splitIndex = input.findIndex((l) => l === "");
    const stackList = input.slice(0, splitIndex - 1);
    const commandsList = input.slice(splitIndex + 1, input.length);

    this.parseStack(stackList);
    this.parseCommands(commandsList);
  }

  private getMaxLaneLength(): number {
    let biggest = 0;

    this.lanes.forEach((lane) => {
      if (lane.crates.length > biggest) {
        biggest = lane.crates.length;
      }
    });

    return biggest;
  }

  private async printLanes() {
    console.clear();

    const max = this.getMaxLaneLength();
    const result: string[] = [];

    for (let i = 0; i < max; i++) {
      const line: string[] = [];

      this.lanes.forEach((lane) => {
        let crate = "   ";

        if (lane.crates[i]) {
          crate = `[${lane.crates[i]}]`;
        }

        line.push(crate);
      });

      result.push(line.join(" "));
    }

    console.log(result.reverse().join(" \n"));
    await awaiter(this.delay);
  }

  private parseStack(list: string[]) {
    list.reverse();

    list.forEach((line) => {
      let innerCount = 0;

      for (let i = 1; i < line.length; i += 4) {
        if (!this.lanes[innerCount]) {
          this.lanes[innerCount] = { id: innerCount, crates: [] };
        }

        const letter = line.at(i);

        if (letter && letter !== " ") {
          this.lanes[innerCount].crates.push(letter);
        }

        innerCount++;
      }
    });

    this.lanes.sort((a, b) => a.id - b.id);
  }

  private parseCommands(list: string[]) {
    list.forEach((cmd) => {
      const [_move, amount, _from, origin, _to, destination] = cmd.split(" ");

      if (!amount || !origin || !destination) {
        throw new Error("Failed to parse command");
      }

      this.commands.push({
        amount: parseInt(amount),
        origin: parseInt(origin) - 1,
        destination: parseInt(destination) - 1,
      });
    });
  }

  public async executeCommands() {
    for (let j = 0; j < this.commands.length; j++) {
      const cmd = this.commands[j];

      const origin = this.lanes.find((l) => l.id === cmd.origin);
      const destination = this.lanes.find((l) => l.id === cmd.destination);

      if (!origin || !destination) {
        throw new Error("Failed to locate origin or destination");
      }

      const lastIndex = origin.crates.length;
      const startIndex = origin.crates.length - cmd.amount;

      const crates = origin.crates.slice(startIndex, lastIndex);
      origin.crates.length = startIndex;
      destination.crates = [...destination.crates, ...crates];

      if (this.showOutPut) {
        await this.printLanes();
      }
    }
  }

  public displayTopCrates() {
    let topCrates = "";

    this.lanes.forEach((lane) => {
      const crate = lane.crates.at(-1);
      topCrates += crate;
    });

    console.log(topCrates);
  }
}

export async function partTwo(input: string[]) {
  const crane = new Crane(input);
  crane.delay = 50
  crane.showOutPut = true;
  await crane.executeCommands();
  crane.displayTopCrates();
}
