import { Controller } from "./Controller.ts";
import { Book } from "/Models/Book.ts";
import { BookService } from "/Service/BookService.ts";

export class BookController extends Controller<Book> {
  constructor() {
    super(new BookService(), Book);
  }
}
