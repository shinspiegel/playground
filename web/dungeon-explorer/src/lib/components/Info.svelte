<script lang="ts">
	import SubTitle from './SubTitle.svelte';
	import Title from './Title.svelte';
	import { infoStore } from '../store';
</script>

<Title>{$infoStore.name}</Title>
<SubTitle>{$infoStore.description}</SubTitle>
