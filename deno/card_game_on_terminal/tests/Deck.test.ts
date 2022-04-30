import {
  assertEquals,
  assertNotEquals,
} from "https://deno.land/std@0.99.0/testing/asserts.ts";
import Card from "../src/Card.ts";
import Deck from "../src/Deck.ts";

/**
 * Você pode não saber, mas testes em aplicações são muito importantes
 * Dessa forma qualquer funcionalidade que exista no código deve ser testada
 * Assim existes bibliotecas para ajudar.
 *
 * Neste caso estamos usando o Deno e ele já possui a própria ferramenta de teste
 * e sua sintáxe é bem simples.
 */

const cards = Array(1000)
  .fill(new Card())
  .map((_, i) => new Card({ name: `Card ${i}` }));

Deno.test("Deve ter um deck vazio", () => {
  const deck = new Deck();

  assertEquals(deck.name, "");
  assertEquals(deck.cards.length, 0);
  assertEquals(deck.usedCards.length, 0);
});

Deno.test("Deve ser possível adicionar uma carta ao deck", () => {
  const deck = new Deck();
  deck.addCard(cards[0]);

  assertEquals(deck.cards.length, 1);
});

Deno.test("Deve ser possível adicionar múltiplas cartas ao deck", () => {
  const deck = new Deck();
  deck.addCards(cards);

  assertEquals(deck.cards.length, 1000);
});

Deno.test("Deve ser possível puxar uma carta", () => {
  const deck = new Deck();
  deck.addCard(cards[0]);

  assertEquals(deck.cards.length, 1);

  const card = deck.drawCard();

  assertEquals(card.name, "Card 0");
  assertEquals(deck.cards.length, 0);
  assertEquals(deck.usedCards.length, 1);
});

Deno.test("Deve ser possível embaralhar o deck", () => {
  const deck = new Deck();

  deck.addCards(cards);

  assertEquals(deck.cards[0].name, "Card 999");

  deck.shuffle();

  assertNotEquals(deck.cards[0].name, "Card 999");
});

Deno.test("Deve gerar um deck aleatório com 10 cartas", async () => {
  const deck = await Deck.random();
  assertEquals(deck.cards.length, 10);
});

Deno.test("Deve gerar um deck aleatório com 50 cartas", async () => {
  const deck = await Deck.random(50);
  assertEquals(deck.cards.length, 50);
});
