<script lang="ts">
  import { FeedbackStore } from "./stores";
  import { v4 as uuid } from "uuid";
  import type { Feedback } from "./types";

  let isDisabled = true;
  let text = "";
  let min = 10;
  let rating = "10";
  let message;

  function handleInput(
    e: Event & { currentTarget: EventTarget & HTMLInputElement }
  ): void {
    checkDisabled(e.currentTarget.value);
  }

  function validateText(text: string): boolean {
    if (text.trim().length <= min) {
      return false;
    }
    return true;
  }

  function checkDisabled(text: string) {
    if (text.trim().length === 0) {
      isDisabled = true;
      message = undefined;
    } else if (text.trim().length < min) {
      isDisabled = true;
      message = `Should have at least ${min} characters long.`;
    } else {
      isDisabled = false;
      message = undefined;
    }
  }

  function handleSubmit(): void {
    if (validateText(text)) {
      const newSubmit: Feedback = {
        text,
        rating: parseInt(rating),
        id: uuid(),
      };

      FeedbackStore.update((current) => (current = [newSubmit, ...current]));

      text = "";
    } else {
      checkDisabled(text);
    }
  }
</script>

<form on:submit|preventDefault={handleSubmit}>
  <div>{rating}</div>

  <input type="range" min="0" max="10" step="1" bind:value={rating} />
  <input type="text" on:input={handleInput} bind:value={text} />

  {#if message}{message}{/if}

  <button type="submit" disabled={isDisabled}>Send</button>
</form>
