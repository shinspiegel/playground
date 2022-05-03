<script lang="ts">
	import { getDiceByChance } from '../functions/getDiceByChance';
	import { sortListByChance } from '../functions/sortListByChance';
	import { encounterStore } from '../store';
	import Title from './Title.svelte';
</script>

<Title>Encounter</Title>
<table>
	<thead>
		<td>Roll</td>
		<td>Encounter</td>
	</thead>

	<tbody>
		{#each sortListByChance($encounterStore) as encounter}
			<tr>
				<td>
					{getDiceByChance(sortListByChance($encounterStore), encounter)}
				</td>
				<td>
					{encounter.description}
				</td>
			</tr>
		{/each}
	</tbody>
</table>
