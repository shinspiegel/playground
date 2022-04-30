<script lang="ts">
  import { FeedbackStore } from "./stores";

  export let rating: number = 0;
  export let id: string;

  function handleDelete(id: string) {
    FeedbackStore.update((current) => current.filter((i) => i.id !== id));
  }
</script>

<div class="feedback">
  <div class="id">{id}</div>
  <div class="rating">{rating}</div>
  <button on:click={() => handleDelete(id)} class="close">&times;</button>
  <slot />
</div>

<style>
  .feedback {
    color: var(--text);
    display: flex;
  }

  .id {
    font-size: 8px;
  }

  .rating {
    font-size: 18px;
  }

  .close {
    font-size: 12px;
  }
</style>
