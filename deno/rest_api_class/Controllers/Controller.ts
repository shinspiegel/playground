import { PostgresError } from "postgres/mod.ts";
import { RouterContext } from "oak/mod.ts";
import { Status } from "std/http/http_status.ts";
import { ModelError } from "../Models/Model.errors.ts";
import { IModel } from "../Models/Model.interface.ts";
import { RepositoryError } from "/Repository/Repository.errors.ts";
import { IService } from "/Service/Service.interface.ts";
import { Logger } from "../Logger/Logger.ts";

export class Controller<MODEL extends IModel> {
  private service: IService<MODEL>;

  constructor(service: IService<MODEL>) {
    this.service = service;
  }

  // deno-lint-ignore no-explicit-any
  raiseError = (context: RouterContext<any>, error: unknown) => {
    Logger.log(error);

    if (
      error instanceof ModelError ||
      error instanceof RepositoryError ||
      error instanceof SyntaxError ||
      error instanceof PostgresError
    ) {
      context.response.status = Status.BadRequest;
      context.response.body = error.message;
      return;
    }

    if (error instanceof Error) {
      context.response.status = Status.InternalServerError;
      context.response.body = error?.message;
      return;
    }

    context.response.status = Status.InternalServerError;
    context.response.body = "Unknown error.";
  };

  // deno-lint-ignore no-explicit-any
  newOne = async (context: RouterContext<any>) => {
    try {
      const body = await context.request.body().value;
      const book = await this.service.create(body);
      context.response.status = Status.Created;
      context.response.body = JSON.stringify(book);
    } catch (error) {
      this.raiseError(context, error);
    }
  };

  // deno-lint-ignore no-explicit-any
  getAll = async (context: RouterContext<any>) => {
    try {
      const books = await this.service.getAll();
      context.response.status = Status.OK;
      context.response.body = JSON.stringify(books);
    } catch (error) {
      this.raiseError(context, error);
    }
  };

  // deno-lint-ignore no-explicit-any
  getOne = async (context: RouterContext<any>) => {
    try {
      const books = await this.service.getById(context.params.id);
      context.response.status = Status.OK;
      context.response.body = JSON.stringify(books);
    } catch (error) {
      this.raiseError(context, error);
    }
  };

  // deno-lint-ignore no-explicit-any
  updateOne = async (context: RouterContext<any>) => {
    try {
      const body = await context.request.body().value;
      const books = await this.service.update(context.params.id, body);
      context.response.status = Status.OK;
      context.response.body = JSON.stringify(books);
    } catch (error) {
      this.raiseError(context, error);
    }
  };

  // deno-lint-ignore no-explicit-any
  deleteOne = async (context: RouterContext<any>) => {
    try {
      const books = await this.service.deleteById(context.params.id);
      context.response.status = Status.OK;
      context.response.body = JSON.stringify(books);
    } catch (error) {
      this.raiseError(context, error);
    }
  };
}
