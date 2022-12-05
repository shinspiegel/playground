import { RouterContext } from "https://deno.land/x/oak/mod.ts";
import { Controller } from "../Controllers/Controller.ts";
import { Book } from "../Models/Book.ts";
import { BookRepository } from "../Repository/BookRepository.ts";

export class BookController extends Controller<Book, BookRepository> {
  constructor() {
    super(new BookRepository());
  }

  newBook = async (context: RouterContext<any>) => {
    const body = await context.request.body().value;
    const book = await this.repo.insertOne(body as Book);
    context.response.body = JSON.stringify(book);
  };

  getAll = async (context: RouterContext<any>) => {
    const book = await this.repo.getAll();
    context.response.body = JSON.stringify(book);
  };

  getBook = async (context: RouterContext<any>) => {
    const { id } = context.params;
    const book = await this.repo.getOneBy({ id: parseInt(id) });
    context.response.body = JSON.stringify(book);
  };

  updateBook = async (context: RouterContext<any>) => {
    const { id } = context.params;
    const body = await context.request.body().value;
    const book = await this.repo.updateOne({ ...body, id } as Book);
    context.response.body = JSON.stringify(book);
  };

  deleteBook = async (context: RouterContext<any>) => {
    const { id } = context.params;
    const book = await this.repo.deleteOne({ id: parseInt(id) });
    context.response.body = JSON.stringify(book);
  };
}
