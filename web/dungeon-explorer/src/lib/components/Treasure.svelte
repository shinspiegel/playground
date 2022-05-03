<script>
	import SubTitle from './SubTitle.svelte';
	import Title from './Title.svelte';
	import TreasureTable from './TreasureTable.svelte';
	import { smallTreasuresStore, bigTreasuresStore } from '../store';
</script>

<Title>Treasures</Title>
<SubTitle>Small Treasures</SubTitle>
<TreasureTable list={$smallTreasuresStore} />
<SubTitle>Big Treasures</SubTitle>
<TreasureTable list={$bigTreasuresStore} />
