import { Router } from "oak/mod.ts";
import { BookController } from "/Controllers/BookController.ts";

export class AppRoutes {
  private router: Router;

  constructor() {
    this.router = new Router();
    this.book();
  }

  private book() {
    const bookController = new BookController();
    this.router.get("/book", bookController.get);
    this.router.get("/book/:id", bookController.show);
    this.router.post("/book", bookController.post);
    this.router.put("/book/:id", bookController.put);
    this.router.delete("/book/:id", bookController.delete);
  }

  public getRoutes() {
    return this.router.routes();
  }

  public allowedMethods() {
    return this.router.allowedMethods();
  }
}
