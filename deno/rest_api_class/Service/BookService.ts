import { BookRepository } from "/Repository/BookRepository.ts";
import { Book } from "/Models/Book.ts";
import { Service } from "/Service/Service.ts";

export class BookService extends Service<Book> {
  constructor() {
    super(new BookRepository(), Book);
  }
}
