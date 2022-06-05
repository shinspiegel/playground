<div class="sheet">
  <div class="stats">stats</div>
  <div class="info">info</div>
  <div class="prof">prof</div>
  <div class="save">save</div>
  <div class="skills">skills</div>
  <div class="profs">profs</div>
  <div class="combat">combat</div>
  <div class="weapons">weapons</div>
  <div class="traits">traits</div>
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
