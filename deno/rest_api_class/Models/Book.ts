import { BookError } from "./Book.errors.ts";
import { IModel } from "/Models/Model.ts";

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
