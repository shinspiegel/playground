import { Status } from "std/http/http_status.ts";
import { RouterContext } from "oak/mod.ts";
import { Controller } from "./Controller.ts";
import { User } from "/Models/User.ts";
import { BookService } from "/Service/BookService.ts";

export class AuthController extends Controller<User> {
  constructor() {
    super(new BookService());
  }

  // deno-lint-ignore no-explicit-any
  login = async (context: RouterContext<any>) => {
    await console.log("login");
    context.response.status = Status.Created;
    context.response.body = JSON.stringify({ ok: true });
  };

  // deno-lint-ignore no-explicit-any
  signup = async (context: RouterContext<any>) => {
    await console.log("login");
    context.response.status = Status.Created;
    context.response.body = JSON.stringify({ ok: true });
  };

  // deno-lint-ignore no-explicit-any
  recover = async (context: RouterContext<any>) => {
    await console.log("login");
    context.response.status = Status.Created;
    context.response.body = JSON.stringify({ ok: true });
  };
}
