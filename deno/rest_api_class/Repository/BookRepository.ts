import { Book } from "/Models/Book.ts";
import { Repository } from "/Repository/Repository.ts";

export class BookRepository extends Repository<Book> {
  constructor() {
    super("books", Book);
  }

  async createTable(): Promise<void> {
    await this.query(`DROP TABLE IF EXISTS ${this.tableName}`);

    await this.query(`
      CREATE TABLE IF NOT EXISTS ${this.tableName} (
        id SERIAL PRIMARY KEY,
        name TEXT NOT NULL,
        isbn TEXT NOT NULL
      )
  `);
  }

  async migrate(): Promise<void> {}

  async seed(): Promise<void> {}
}
