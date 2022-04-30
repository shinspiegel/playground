import { assertEquals } from "https://deno.land/std@0.99.0/testing/asserts.ts";
import Random from "../src/Random.ts";

/**
 * Você pode não saber, mas testes em aplicações são muito importantes
 * Dessa forma qualquer funcionalidade que exista no código deve ser testada
 * Assim existes bibliotecas para ajudar.
 *
 * Neste caso estamos usando o Deno e ele já possui a própria ferramenta de teste
 * e sua sintáxe é bem simples.
 */

Deno.test("Deve gerar um numero entre 1 e 3", () => {
  const rand = Random.range(1, 3);

  assertEquals(rand < 3, true);
  assertEquals(rand >= 1, true);
});

Deno.test("Deve gerar um numero entre 0 e 1", () => {
  const rand = Random.range(0, 1);
  assertEquals(rand, 0);
});

Deno.test("Deve gerar um nome aleatório", async () => {
  const rand = await Random.nameFromJson();
  assertEquals(rand.length > 0, true);
});
