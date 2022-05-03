import type { CanBeRolled, Identifiable } from '../types';

export const getDiceByChance = <T extends unknown & CanBeRolled & Identifiable>(
	list: T[],
	item: T
): string => {
	const sorted = [...list].sort((a, b) => b.chance - a.chance);
	const indexItem = sorted.findIndex((i) => i.id === item.id);
	const startResult = sorted.slice(0, indexItem).reduce((p, c) => p + c.chance, 1);
	const endResult = sorted.slice(0, indexItem + 1).reduce((p, c) => p + c.chance, 0);

	if (startResult === endResult) {
		return `${endResult}`;
	}

	return `${startResult}-${endResult}`;
};
