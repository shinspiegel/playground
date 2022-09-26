import { Battle } from "./Battle.ts";
import { Character } from "./Character.ts";
import { Dice } from "./Dice.ts";

const battle = new Battle(
  new Character({
    skill: Dice.d10,
    target: 3,
  }),
  new Character({
    skill: Dice.d4,
    target: 3,
  })
);
battle.contestFor(10_000_000);
battle.showResults();
