<script>
	import { pokemonStore } from '../stores/PokeStore';
</script>

<svelte:head>
	<title>Updated</title>
</svelte:head>

<h1 class="text" >Poke Api Crash Course</h1>

{#each $pokemonStore as pokemon}
	<div>
		{pokemon.name}
	</div>
{/each}
