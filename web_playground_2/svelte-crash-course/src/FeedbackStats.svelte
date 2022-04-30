<script lang="ts">
  import { FeedbackStore } from "./stores";
  import { calculateAverage, calculateCount } from "./utils";

  $: count = calculateCount($FeedbackStore);
  $: average = calculateAverage($FeedbackStore);
</script>

<div>
  {count} total. Average of {average}
</div>
