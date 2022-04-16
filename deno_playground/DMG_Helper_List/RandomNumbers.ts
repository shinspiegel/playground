export function randomRange(min: number, max: number) {
  return Math.floor(Math.random() * (max - min + 1) + min);
}

export function randomStat() {
  const dices = [randomRange(1, 6), randomRange(1, 6), randomRange(1, 6), randomRange(1, 6)];
  const min = Math.min(...dices);

  return dices.reduce((acc, dice) => acc + dice, 0) - min;
}

export function random(max: number) {
  return randomRange(0, max) - 1;
}
