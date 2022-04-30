import type { CanBeRolled } from '../types';

export function sortListByChance<T extends unknown & CanBeRolled>(list: T[]): T[] {
	return [...list].sort((a, b) => b.chance - a.chance);
}
