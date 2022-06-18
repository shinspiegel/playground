export function sortByWeight<T extends { weight: number }>(a: T, b: T) {
  if (a.weight > b.weight) {
    return 1;
  }

  if (a.weight < b.weight) {
    return -1;
  }

  return 0;
}
