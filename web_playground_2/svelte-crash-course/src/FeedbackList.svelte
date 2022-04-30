<script lang="ts">
  import { FeedbackStore } from "./stores";
  import { fade, slide } from "svelte/transition";
  import Card from "./Card.svelte";
  import FeedbackItem from "./FeedbackItem.svelte";
</script>

Feedback List

{#each $FeedbackStore as { id, rating, text }}
  <div>
    <Card>
      <FeedbackItem {id} {rating}>
        {text}
      </FeedbackItem>
    </Card>
  </div>
{/each}
