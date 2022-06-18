<script lang="ts">
  import Combat from "../lib/Combat.svelte";
  import Info from "../lib/Info.svelte";
  import Proficiencies from "../lib/Proficiencies.svelte";
  import ProficiencyBonus from "../lib/ProficiencyBonus.svelte";
  import SavingThrows from "../lib/SavingThrows.svelte";
  import Skills from "../lib/Skills.svelte";
  import Stats from "../lib/Stats.svelte";
  import Traits from "../lib/Traits.svelte";
  import WeaponsAndAttacks from "../lib/WeaponsAndAttacks.svelte";
</script>

<div class="sheet">
  <div class="stats">
    <Stats />
  </div>

  <div class="info">
    <Info />
  </div>

  <div class="prof">
    <ProficiencyBonus />
  </div>

  <div class="save">
    <SavingThrows />
  </div>

  <div class="skills">
    <Skills />
  </div>

  <div class="profs">
    <Proficiencies />
  </div>

  <div class="combat">
    <Combat />
  </div>

  <div class="weapons">
    <WeaponsAndAttacks />
  </div>

  <div class="traits">
    <Traits />
  </div>
</div>

<style lang="scss">
  .sheet {
    height: 100vh;
    display: grid;
    grid-template-columns: 1fr 1fr 1fr 2fr;
    grid-template-rows: 10fr 10fr 10fr 10fr 10fr;
    grid-template-areas:
      "stats  info    info     traits"
      "stats  prof    combat   traits"
      "stats  save    weapons  traits"
      "stats  skills  weapons  traits"
      "stats  profs   weapons  traits";
  }

  .stats {
    grid-area: stats;
    background: red;
  }

  .info {
    grid-area: info;
    background: teal;
  }

  .prof {
    grid-area: prof;
    background: green;
  }

  .save {
    grid-area: save;
    background: blue;
  }

  .skills {
    grid-area: skills;
    background: magenta;
  }

  .profs {
    grid-area: profs;
    background: yellow;
  }

  .combat {
    grid-area: combat;
    background: violet;
  }

  .weapons {
    grid-area: weapons;
    background: olive;
  }

  .traits {
    grid-area: traits;
    background: indianred;
  }
</style>
