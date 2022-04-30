import type { CanBeRolled } from '../types';

export const sortListByChance = <T extends unknown & CanBeRolled>(list: T[]): T[] => {
	return [...list].sort((a, b) => b.chance - a.chance);
};
