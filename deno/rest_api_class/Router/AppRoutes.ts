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
    this.router.get("/book", bookController.getAll);
    this.router.get("/book/:id", bookController.getOne);
    this.router.post("/book", bookController.newOne);
    this.router.put("/book/:id", bookController.updateOne);
    this.router.delete("/book/:id", bookController.deleteOne);
  }

  public getRoutes() {
    return this.router.routes();
  }

  public allowedMethods() {
    return this.router.allowedMethods();
  }
}
