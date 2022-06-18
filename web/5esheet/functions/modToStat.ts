export function modToStat(mod: number): number {
  if (mod <= -5) {
    return 1;
  }

  return mod * 2 + 10;
}
