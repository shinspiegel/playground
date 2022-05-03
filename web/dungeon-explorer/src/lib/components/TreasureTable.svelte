<script lang="ts">
	import type { Treasure } from '../types';
	import { getDiceByChance } from '../functions/getDiceByChance';
	import { sortListByChance } from '../functions/sortListByChance';

	export let list: Treasure[];
</script>

<table>
	<thead>
		<td>Roll</td>
		<td>Looted?</td>
		<td>Descriptions</td>
	</thead>

	<tbody>
		{#each sortListByChance(list) as treasure}
			<tr>
				<td>
					<label for={`${treasure.id}_small-treasure`}>
						{getDiceByChance(sortListByChance(list), treasure)}
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
