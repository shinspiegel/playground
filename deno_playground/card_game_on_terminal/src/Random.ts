import ReadFile from "./ReadFile.ts";

/**
 * Este é uma classe de suporte para gerar coisas aleatórias
 * Ela gera nomes e gera também números
 * Os nomes são lido por um arquivo em JSON
 */
export default class Random {
  /**
   * Retorna uma string completamente aleatória de acordo com coisa aquivo JSON
   * Estes arquivos estão na pasta assets
   * @returns Este é um nome aleatório vindo de duas listas, uma de adjetivos e outro de nomes
   */
  static async nameFromJson(): Promise<string> {
    const adjectivesPath = `${Deno.cwd()}/assets/adjectives.json`;
    const namesPath = `${Deno.cwd()}/assets/names.json`;

    const adjectives: string[] = await ReadFile.json(adjectivesPath);
    const names: string[] = await ReadFile.json(namesPath);

    const word1 = adjectives[Random.range(0, adjectives.length)];
    const word2 = names[Random.range(0, names.length)];

    return `${word1} ${word2}`;
  }

  /**
   * Irá gerar um número entre o mínimo (ele inclusivo) e o máximo (não incluso)
   * @param min Menor valor
   * @param max Maior valor
   * @returns Numero aleatório entre dois números
   */
  static range(min: number, max: number): number {
    return Math.floor(Math.random() * (max - min)) + min;
  }
}
