type Hand = "rock" | "paper" | "scissor";

class RockPaperScissor {
  private elf: Hand;
  private player: Hand;
  private playerScore = 0;
  private matchScore = 0;

  constructor(elf: string, player: string) {
    this.elf = this.decodeElf(elf);
    this.player = this.decodePlayer(player);
    this.calculatePlayerScore();
    this.match();
  }

  private decodePlayer(entry: string): Hand {
    if (this.elf === "rock") {
      if (entry === "X") return "scissor";
      if (entry === "Y") return "rock";
      if (entry === "Z") return "paper";
    }

    if (this.elf === "paper") {
      if (entry === "X") return "rock";
      if (entry === "Y") return "paper";
      if (entry === "Z") return "scissor";
    }

    if (this.elf === "scissor") {
      if (entry === "X") return "paper";
      if (entry === "Y") return "scissor";
      if (entry === "Z") return "rock";
    }

    throw new Error("Failed to decode");
  }

  private decodeElf(entry: string): Hand {
    if (entry === "A") {
      return "rock";
    }

    if (entry === "B") {
      return "paper";
    }

    if (entry === "C") {
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

export function partTwo(input: string[]) {
  let total = 0;

  input
    .map((line) => line.split(" "))
    .forEach(([elf, player]) => {
      const rps = new RockPaperScissor(elf, player);
      total += rps.result;
    });

  console.log(total);
}
