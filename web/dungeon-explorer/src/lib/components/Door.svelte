<script lang="ts">
	import type { Identifiable } from '../types';
	import { doorStore, roomsStore } from '../store';

	export let id: Identifiable['id'];
	let door = $doorStore.find((d) => d.id === id);
</script>

{#if door}
	{door?.description} that leads to:
	{#each door.rooms as roomId}
		{$roomsStore.find((r) => r.id === roomId)?.description}{' '}
	{/each}
{/if}
