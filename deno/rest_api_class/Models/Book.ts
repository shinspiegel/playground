import { IModel } from "./Model.ts";

export class BookError extends Error {
  constructor(msg: string) {
    super(msg);
  }
}

export class Book implements IModel {
  public id?: number;
  public name?: string;
  public isbn?: string;

  fromRow(row: unknown): Book {
    if (!Array.isArray(row)) {
      throw new BookError("Invalid row data");
    }

    this.id = row[0];
    this.name = row[1];
    this.isbn = row[2];

    return this;
  }
}
