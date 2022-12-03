type Hand = "rock" | "paper" | "scissor";

class RockPaperScissor {
  private elf: Hand;
  private player: Hand;
  private playerScore = 0;
  private matchScore = 0;

  constructor(elf: string, player: string) {
    this.elf = this.decode(elf);
    this.player = this.decode(player);
    this.calculatePlayerScore();
    this.match();
  }

  private decode(entry: string): Hand {
    if (entry === "A" || entry === "X") {
      return "rock";
    }

    if (entry === "B" || entry === "Y") {
      return "paper";
    }

    if (entry === "C" || entry === "Z") {
      return "scissor";
    }

    throw new Error("Failed to decode");
  }

  private calculatePlayerScore() {
    if (this.player === "rock") {
      this.playerScore = 1;
    }
    if (this.player === "paper") {
      this.playerScore = 2;
    }
    if (this.player === "scissor") {
      this.playerScore = 3;
    }
  }

  private match() {
    if (this.player === this.elf) {
      this.matchScore = 3;
    }

    if (
      (this.player === "rock" && this.elf === "scissor") ||
      (this.player === "paper" && this.elf === "rock") ||
      (this.player === "scissor" && this.elf === "paper")
    ) {
      this.matchScore = 6;
    }

    if (
      (this.elf === "rock" && this.player === "scissor") ||
      (this.elf === "paper" && this.player === "rock") ||
      (this.elf === "scissor" && this.player === "paper")
    ) {
      this.matchScore = 0;
    }
  }

  public get result(): number {
    return this.playerScore + this.matchScore;
  }
}

export function partOne(input: string[]) {
  let total = 0;

  input
    .map((line) => line.split(" "))
    .forEach(([elf, player]) => {
      const rps = new RockPaperScissor(elf, player);
      total += rps.result;
    });

  console.log(total);
}
