import { Stat } from '../stores';

export function statSort(a: Stat, b: Stat) {
  if (a.order > b.order) return 1;
  if (a.order < b.order) return -1;

  return a.name.localeCompare(b.name);
}
