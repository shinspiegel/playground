export class Dice {
  static roll(max = 6, min = 1) {
    return Math.floor(Math.random() * (max - min + 1) + min);
  }
  static d20() {
    return Dice.roll(20);
  }
  static d12() {
    return Dice.roll(12);
  }
  static d10() {
    return Dice.roll(10);
  }
  static d8() {
    return Dice.roll(8);
  }
  static d6() {
    return Dice.roll(6);
  }
  static d4() {
    return Dice.roll(4);
  }
}

