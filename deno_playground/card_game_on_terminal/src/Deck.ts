import Random from "./Random.ts";
import Card from "./Card.ts";

/**
 * Esta é a classe que controla o deck.
 * Tudo que é relacionado
 * - a lista de cartas a pilha (`cards`)
 * - a lista de descarte (`usedCards`)
 * - a comprar cartas
 * - a adicionar carta
 */
export default class Deck {
  name = "";
  cards: Card[] = [];
  usedCards: Card[] = [];

  /**
   * Este método irá adicionar ao topo da pilha de cartas (`cards`)
   * @param card Esta é a carta
   * @returns Sempre retorna a própria classe. Para encadear métodos.
   */
  addCard(card: Card): this {
    this.cards.unshift(card);
    return this;
  }

  /**
   * Este método irá adicionar as cartas ao todo.
   * A primeira carta do topo será a ultíma adicionada.
   * Se tiver uma pilha com [1, 2, 3], e for adicionar ao deck
   * ele ficará com [3, 2, 1], porque é do topo para cada
   * @param cards Uma array de cartas
   * @returns Sempre retorna a própria classe. Para encadear métodos.
   */
  addCards(cards: Card[]): this {
    cards.forEach((card) => this.addCard(card));
    return this;
  }

  /**
   * Irá embaralhar a pilha de cartas (`cards`).
   * Como o JS não tem um método para fazer `shuffle`
   * utilizei um truque bobo, fazer um sort, mas o peso da carta
   * é aleatório, sendo 0.5 pra cima ou baixo.
   * @returns Sempre retorna a própria classe. Para encadear métodos.
   */
  shuffle(): this {
    this.cards.sort(() => Math.random() - 0.5);
    return this;
  }

  /**
   * Remove a carta do topo da pilha (`cards`), e então
   * adiciona a mesma carta a pilha de descarte (`usedCards`)
   * @returns Retorna uma referencia do topo da carta.
   */
  drawCard(): Card {
    if (this.cards.length > 0) {
      const card = this.cards.shift()!;
      this.usedCards.unshift(card);
      return card;
    } else {
      throw new Error("Lista de cartas está vazia.");
    }
  }

  /**
   * Vai gerar um deck aleatório, com cartas aleatórias.
   * Se pode definir a quantidade de cartas, mas o padrão é 10.
   * @param amount Quantidade de cartas no deck. Default é 10
   * @returns Retorna um `deck` com a quantidade de cartas
   */
  static async random(amount = 10): Promise<Deck> {
    const deck = new Deck();
    const cards: Card[] = [];

    for (let i = 0; i < amount; i++) {
      cards.push(await Card.random());
    }

    deck.name = await Random.nameFromJson();
    deck.addCards(cards);

    return deck;
  }
}
