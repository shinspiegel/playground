import { RouterContext } from "oak/mod.ts";
import { Status } from "std/http/http_status.ts";
import { IModel } from "../Models/Model.interface.ts";
import { RepositoryError } from "/Repository/Repository.errors.ts";
import { IService } from "/Service/Service.ts";

export class Controller<MODEL extends IModel> {
  private service: IService<MODEL>;

  constructor(service: IService<MODEL>) {
    this.service = service;
  }

  // deno-lint-ignore no-explicit-any
  newOne = async (context: RouterContext<any>) => {
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

  // deno-lint-ignore no-explicit-any
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

  // deno-lint-ignore no-explicit-any
  getOne = async (context: RouterContext<any>) => {
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

  // deno-lint-ignore no-explicit-any
  updateOne = async (context: RouterContext<any>) => {
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

  // deno-lint-ignore no-explicit-any
  deleteOne = async (context: RouterContext<any>) => {
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
