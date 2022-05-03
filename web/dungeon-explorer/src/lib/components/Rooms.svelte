<script>
	import Title from './Title.svelte';
	import Door from './Door.svelte';
	import { roomsStore } from '../store';
</script>

<Title>Rooms</Title>
<ul>
	{#each $roomsStore as room}
		<li>
			{room.description}

			<ul>
				{#each room.doors as id}
					<li><Door {id} /></li>
				{/each}
			</ul>
		</li>
	{/each}
</ul>
