<script lang="ts">
  import { sortByWeight } from "../functions/sortByWeight";

  import { statsStore, type Stat } from "../stores";

  type OnBlur = FocusEvent & { currentTarget: EventTarget & HTMLInputElement };
  type BlurOption = keyof Pick<Stat, "mod" | "value">;

  function onBlur(name: string, option: BlurOption, e: OnBlur) {
    statsStore.update((list) => {
      const stat = list.find((s) => (s.name = name));

      if (stat) {
        stat.mod = 10;

        // console.log(stat, option, e.currentTarget.value);
      }

      // debugger;

      return list.sort(sortByWeight);
    });
  }
</script>

<ul>
  {#each $statsStore as stat}
    <li>
      <div>{stat.name}</div>
      <input bind:value={stat.value} on:blur={(e) => onBlur(stat.name, "value", e)} />
      <input bind:value={stat.value} on:blur={(e) => onBlur(stat.name, "mod", e)} />
    </li>
  {/each}
</ul>
