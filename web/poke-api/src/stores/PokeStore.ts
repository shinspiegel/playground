import { writable } from 'svelte/store';

export const pokemonStore = writable<Pokemon[]>([]);

export type Pokemon = {
	id: number;
	name: string;
	image: string;
};

const fetchPokemon = async () => {
	const url = 'https://pokeapi.co/api/v2/pokemon?limit=150';
	const res = await fetch(url);
	const data = await res.json();

	const updated: Pokemon[] = data.results.map((data, index) => ({
		id: index + 1,
		name: data.name,
		image: `https://raw.githubusercontent.com/PokeApi/sprites/master/sprites/pokemon/${
			index + 1
		}.png`
	}));

	pokemonStore.set(updated);
};

fetchPokemon();
