import {
  assertEquals,
  assertNotEquals,
} from "https://deno.land/std@0.99.0/testing/asserts.ts";
import Card from "../src/Card.ts";

/**
 * Você pode não saber, mas testes em aplicações são muito importantes
 * Dessa forma qualquer funcionalidade que exista no código deve ser testada
 * Assim existes bibliotecas para ajudar.
 *
 * Neste caso estamos usando o Deno e ele já possui a própria ferramenta de teste
 * e sua sintáxe é bem simples.
 */

Deno.test("Deve ter uma carta vazia", () => {
  const card = new Card();
  assertEquals(card.name, "");
  assertEquals(card.power, 0);
  assertEquals(card.speed, 0);
  assertEquals(card.control, 0);
});

Deno.test("Deve ter uma carta com os dados do objeto", () => {
  const card = new Card({
    name: "Nome da Carta",
    power: 1,
    speed: 2,
    control: 3,
  });

  assertEquals(card.name, "Nome da Carta");
  assertEquals(card.power, 1);
  assertEquals(card.speed, 2);
  assertEquals(card.control, 3);
});

Deno.test("Deve gerar uma carta aleatória", async () => {
  const card = await Card.random();
  assertNotEquals(card.name, "");
  assertNotEquals(card.power, 0);
  assertNotEquals(card.speed, 0);
  assertNotEquals(card.control, 0);
});
