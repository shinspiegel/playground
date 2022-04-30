export type Dungeon = {
	info: Info;
	treasures: Treasures;
	randomEncounters: Encounter[];
	rooms: Room[];
	doors: Door[];
};

export type Identifiable = { id: number | string };
export type CanBeRolled = { chance: number };
export type CanBeDescribed = { description: string };

export type Info = CanBeDescribed & { name: string };

export type Treasures = {
	smallTreasures: Treasure[];
	bigTreasures: Treasure[];
};

export type Treasure = CanBeRolled & CanBeDescribed & Identifiable & { isLooted?: boolean };

export type Encounter = CanBeRolled & CanBeDescribed & Identifiable;

export type Room = Identifiable &
	CanBeDescribed & {
		doors: Door['id'][];
		treasure?: Treasure['id'][];
		encounter?: Encounter['id'];
	};

export type Door = Identifiable &
	CanBeDescribed & {
		rooms: Room['id'][];
		key?: string;
	};
