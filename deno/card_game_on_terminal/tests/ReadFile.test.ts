import { assertEquals } from "https://deno.land/std@0.99.0/testing/asserts.ts";
import ReadFile from "../src/ReadFile.ts";

/**
 * Você pode não saber, mas testes em aplicações são muito importantes
 * Dessa forma qualquer funcionalidade que exista no código deve ser testada
 * Assim existes bibliotecas para ajudar.
 *
 * Neste caso estamos usando o Deno e ele já possui a própria ferramenta de teste
 * e sua sintáxe é bem simples.
 */

Deno.test("Deve gerar um numero entre 1 e 3", async () => {
  const path = `${Deno.cwd()}/tests/dummy.json`;
  const file: { key: string } = await ReadFile.json(path);
  assertEquals(file.key, "value");
});
