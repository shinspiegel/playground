export function statToMod(stat: number): number {
  if (stat <= 0) {
    return -5;
  }

  return Math.floor((stat - 10) / 2);
}
