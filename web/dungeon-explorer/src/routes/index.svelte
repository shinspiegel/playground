<script lang="ts">
	import Info from '../components/Info.svelte';
	import Treasure from '../components/Treasure.svelte';
	import type { CanBeRolled, Dungeon, Identifiable } from '../types';

	const dungeon: Dungeon = {
		info: {
			name: 'dungeon name',
			description: 'some descriptive text'
		},

		treasures: {
			smallTreasures: [
				{ id: 0, description: 'sm-tre-0', chance: 1 },
				{ id: 1, description: 'sm-tre-1', chance: 4 },
				{ id: 2, description: 'sm-tre-2', chance: 1 }
			],
			bigTreasures: [
				{ id: 0, description: 'bg-tre-0', chance: 5 },
				{ id: 1, description: 'bg-tre-1', chance: 4 },
				{ id: 2, description: 'bg-tre-2', chance: 1 }
			]
		},

		randomEncounters: [
			{ id: 0, chance: 5, description: 'enc-0' },
			{ id: 1, chance: 4, description: 'enc-1' },
			{ id: 2, chance: 1, description: 'enc-2' }
		],

		rooms: [
			{ id: 0, description: 'room-0', doors: [0] },
			{ id: 1, description: 'room-1', doors: [0, 1, 2] },
			{ id: 2, description: 'room-2', doors: [2] }
		],

		doors: [
			{ id: 0, rooms: [0, 1], description: 'door-0' },
			{ id: 1, rooms: [1, 2], description: 'door-1' },
			{ id: 2, rooms: [2, 0], description: 'door-2' }
		]
	};
</script>

<Info name={dungeon.info.name} description={dungeon.info.description} />

<Treasure title="Small Treasures" list={dungeon.treasures.smallTreasures} />

<h2>Treasures</h2>
<h3>Small Treasure</h3>
<table>
	<thead>
		<td>Roll</td>
		<td>Looted?</td>
		<td>Descriptions</td>
	</thead>

	<tbody>
		{#each sortListByChance(dungeon.treasures.smallTreasures) as treasure}
			<tr>
				<td>
					<label for={`${treasure.id}_small-treasure`}>
						{getDiceByChance(sortListByChance(dungeon.treasures.smallTreasures), treasure)}
					</label>
				</td>
				<td>
					<input
						type="checkbox"
						bind:checked={treasure.isLooted}
						id={`${treasure.id}_small-treasure`}
					/>
				</td>
				<td>
					<label for={`${treasure.id}_small-treasure`}>
						{treasure.description}
					</label>
				</td>
			</tr>
		{/each}
	</tbody>
</table>

<h3>Big Treasure</h3>
<table>
	<thead>
		<td>Roll</td>
		<td>Looted?</td>
		<td>Descriptions</td>
	</thead>

	<tbody>
		{#each sortListByChance(dungeon.treasures.bigTreasures) as treasure}
			<tr>
				<td>
					<label for={`${treasure.id}_big-treasure`}>
						{getDiceByChance(sortListByChance(dungeon.treasures.bigTreasures), treasure)}
					</label>
				</td>
				<td>
					<input
						type="checkbox"
						bind:checked={treasure.isLooted}
						id={`${treasure.id}_big-treasure`}
					/>
				</td>
				<td>
					<label for={`${treasure.id}_big-treasure`}>
						{treasure.description}
					</label>
				</td>
			</tr>
		{/each}
	</tbody>
</table>

<h2>Random Encounters</h2>
<table>
	<thead>
		<td>Roll</td>
		<td>Encounter</td>
	</thead>

	<tbody>
		{#each sortListByChance(dungeon.randomEncounters) as encounter}
			<tr>
				<td>
					{getDiceByChance(sortListByChance(dungeon.randomEncounters), encounter)}
				</td>
				<td>
					{encounter.description}
				</td>
			</tr>
		{/each}
	</tbody>
</table>

<style lang="scss">
</style>
