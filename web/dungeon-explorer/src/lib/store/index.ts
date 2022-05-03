import { writable } from 'svelte/store';
import type { Info, Treasure, Encounter, Room, Door } from '../types';

export const infoStore = writable<Info>({
	name: 'dungeon name',
	description: 'some descriptive text'
});

export const smallTreasuresStore = writable<Treasure[]>([
	{ id: 0, description: 'sm-tre-0', chance: 1 },
	{ id: 1, description: 'sm-tre-1', chance: 4 },
	{ id: 2, description: 'sm-tre-2', chance: 1 }
]);

export const bigTreasuresStore = writable<Treasure[]>([
	{ id: 0, description: 'bg-tre-0', chance: 5 },
	{ id: 1, description: 'bg-tre-1', chance: 4 },
	{ id: 2, description: 'bg-tre-2', chance: 1 }
]);

export const encounterStore = writable<Encounter[]>([
	{ id: 0, chance: 5, description: 'enc-0' },
	{ id: 1, chance: 4, description: 'enc-1' },
	{ id: 2, chance: 1, description: 'enc-2' }
]);

export const roomsStore = writable<Room[]>([
	{ id: 0, description: 'room-0', doors: [0] },
	{ id: 1, description: 'room-1', doors: [0, 1, 2] },
	{ id: 2, description: 'room-2', doors: [2] }
]);

export const doorStore = writable<Door[]>([
	{ id: 0, rooms: [0, 1], description: 'door-0' },
	{ id: 1, rooms: [1, 2], description: 'door-1' },
	{ id: 2, rooms: [2, 0], description: 'door-2' }
]);
