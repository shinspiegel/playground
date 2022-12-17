import { RouterContext } from "oak/mod.ts";
import { Status } from "std/http/http_status.ts";
import { ModelError } from "../Models/Model.errors.ts";
import { IModel } from "../Models/Model.interface.ts";
import { RepositoryError } from "/Repository/Repository.errors.ts";
import { IService } from "/Service/Service.ts";

export class Controller<MODEL extends IModel> {
  private service: IService<MODEL>;
  private model: new () => MODEL;

  constructor(service: IService<MODEL>, model: new () => MODEL) {
    this.service = service;
    this.model = model;
  }

  validateBody = (body: unknown) => {
    const model = new this.model();
    model.validate(body);
  };

  // deno-lint-ignore no-explicit-any
  raiseError = (context: RouterContext<any>, error: unknown) => {
    if (error instanceof ModelError || error instanceof RepositoryError || error instanceof SyntaxError) {
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
      this.validateBody(body);
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
      const books = await this.service.getOne(await context.request.body().value);
      context.response.status = Status.OK;
      context.response.body = JSON.stringify(books);
    } catch (error) {
      this.raiseError(context, error);
    }
  };

  // deno-lint-ignore no-explicit-any
  updateOne = async (context: RouterContext<any>) => {
    try {
      const books = await this.service.update(await context.request.body().value);
      context.response.status = Status.OK;
      context.response.body = JSON.stringify(books);
    } catch (error) {
      this.raiseError(context, error);
    }
  };

  // deno-lint-ignore no-explicit-any
  deleteOne = async (context: RouterContext<any>) => {
    try {
      const books = await this.service.delete(await context.request.body().value);
      context.response.status = Status.OK;
      context.response.body = JSON.stringify(books);
    } catch (error) {
      this.raiseError(context, error);
    }
  };
}
