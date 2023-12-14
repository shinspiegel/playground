export type Trip = {
	id: number;
	userId: number;
	name: string;
	photos?: Photo[];
};

export type Photo = {
	id: number;
	latitude: number;
	longitude: number;
	timestamp: number;
};
