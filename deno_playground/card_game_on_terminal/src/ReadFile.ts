/**
 * Classe para leitura de arquivos diversos.
 */
export default class ReadFile {
  /**
   * Lê um arquivo e faz um parse dele
   * @param path Caminho para o arquivo
   * @returns Retorna o objeto JSON
   */
  static async json(path: string) {
    return JSON.parse(await Deno.readTextFile(path));
  }
}
