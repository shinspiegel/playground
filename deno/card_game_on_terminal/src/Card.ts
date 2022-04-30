import Random from "./Random.ts";

/**
 * Tipo opcional para construtor da classe `Card`
 * Cada argumento neste tipo é opcional
 * Dessa forma quando for construir a carta
 * se pode passar qualquer argumento dos listados
 * abaixo e a carta ainda será válida.
 */
export type cardOptions = {
  name?: string;
  power?: number;
  speed?: number;
  control?: number;
};

/**
 * Esta é a classe básica para as cartas do jogo.
 * Seu construtor é opcional. Nesse caso pode ser deixado vazio.
 * Caso queria passar algo para o construtor, deve passar um
 * objeto com as informações do `cardOptions`
 */
export default class Card {
  name = "";
  power = 0;
  speed = 0;
  control = 0;

  /**
   * O construtor é opcional.
   * Se tiver informações vai verificar cada propriedade do objeto e carregar
   * a informação relevante a propriedade correta.
   * @param option Objeto para carregar o construtor.
   */
  constructor(option?: cardOptions) {
    if (option) {
      if (option.name) {
        this.name = option.name;
      }

      if (option.power) {
        this.power = option.power;
      }

      if (option.speed) {
        this.speed = option.speed;
      }

      if (option.control) {
        this.control = option.control;
      }
    }
  }

  /**
   * Esta é uma carta aleatória.
   * Esse método é estático e retorna o objecto da carta construído.
   * @returns Carta aleatória
   */
  static async random(): Promise<Card> {
    const card = new Card();

    card.name = await Random.nameFromJson();
    card.power = Random.range(1, 10);
    card.speed = Random.range(1, 10);
    card.control = Random.range(1, 10);

    return card;
  }
}
