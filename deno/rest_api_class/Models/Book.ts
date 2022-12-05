import { Model } from "./Model.ts";

export class BookErro extends Error {
  constructor(msg: string) {
    super(msg);
  }
}

export class Book extends Model {
  public name?: string;
  public isbn?: string;

  fromRow(row: unknown): Book {
    if (!Array.isArray(row)) {
      throw new BookErro("Invalid row data");
    }

    this.id = row[0];
    this.name = row[1];
    this.isbn = row[2];

    return this;
  }
}
