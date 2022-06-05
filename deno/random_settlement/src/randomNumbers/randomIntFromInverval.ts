export type RandomIntFromIntervalOptions = { min?: number; max?: number };

export function randomIntFromInterval({ min = 1, max = 100 }: RandomIntFromIntervalOptions): number {
  return Math.floor(Math.random() * (max - min + 1) + min);
}
