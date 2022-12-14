import { RouterContext } from "oak/mod.ts";
import { Status } from "std/http/http_status.ts";
import { Book } from "/Models/Book.ts";
import { RepositoryError } from "/Repository/Repository.errors.ts";
import { BookService } from "/Service/BookService.ts";
import { IService } from "/Service/Service.ts";

export class BookController {
  private service: IService<Book> = new BookService();

  newBook = async (context: RouterContext<any>) => {
    try {
      const book = await this.service.create(await context.request.body().value);
      context.response.status = Status.Created;
      context.response.body = JSON.stringify(book);
    } catch (err) {
      if (err instanceof RepositoryError || err instanceof SyntaxError) {
        context.response.status = Status.BadRequest;
        context.response.body = err.message;
        return;
      }
      context.response.status = Status.InternalServerError;
      context.response.body = JSON.stringify(err);
    }
  };

  getAll = async (context: RouterContext<any>) => {
    try {
      const books = await this.service.getAll();
      context.response.status = Status.OK;
      context.response.body = JSON.stringify(books);
    } catch (err) {
      if (err instanceof RepositoryError) {
        context.response.status = Status.BadRequest;
        return;
      }
      context.response.status = Status.InternalServerError;
      context.response.body = JSON.stringify(err);
    }
  };

  getBook = async (context: RouterContext<any>) => {
    try {
      const books = await this.service.getOne(await context.request.body().value);
      context.response.status = Status.OK;
      context.response.body = JSON.stringify(books);
    } catch (err) {
      if (err instanceof RepositoryError) {
        context.response.status = Status.BadRequest;
        return;
      }
      context.response.status = Status.InternalServerError;
      context.response.body = JSON.stringify(err);
    }
  };

  updateBook = async (context: RouterContext<any>) => {
    try {
      const books = await this.service.update(await context.request.body().value);
      context.response.status = Status.OK;
      context.response.body = JSON.stringify(books);
    } catch (err) {
      if (err instanceof RepositoryError) {
        context.response.status = Status.BadRequest;
        return;
      }
      context.response.status = Status.InternalServerError;
      context.response.body = JSON.stringify(err);
    }
  };

  deleteBook = async (context: RouterContext<any>) => {
    try {
      const books = await this.service.delete(await context.request.body().value);
      context.response.status = Status.OK;
      context.response.body = JSON.stringify(books);
    } catch (err) {
      if (err instanceof RepositoryError) {
        context.response.status = Status.BadRequest;
        return;
      }
      context.response.status = Status.InternalServerError;
      context.response.body = JSON.stringify(err);
    }
  };
}
