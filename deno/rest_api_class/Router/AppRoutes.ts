import { Router } from "oak/mod.ts";
import { BookController } from "/Controllers/BookController.ts";
import { AuthController } from "/Controllers/AuthController.ts";

export class AppRoutes {
  private router: Router;

  constructor() {
    this.router = new Router();
    this.auth();
    this.book();
  }

  private auth() {
    const controller = new AuthController();
    this.router.post("/auth/login", controller.login);
    this.router.post("/auth/signup", controller.signup);
    this.router.post("/auth/recover", controller.recover);
  }

  private book() {
    const controller = new BookController();
    this.router.get("/book", controller.get);
    this.router.get("/book/:id", controller.show);
    this.router.post("/book", controller.post);
    this.router.put("/book/:id", controller.put);
    this.router.delete("/book/:id", controller.delete);
  }

  public getRoutes() {
    return this.router.routes();
  }

  public allowedMethods() {
    return this.router.allowedMethods();
  }
}
