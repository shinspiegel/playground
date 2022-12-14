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

    console.log("Creating book routes");

    this.router.get("/book", bookController.getAll);
    this.router.get("/book/:id", bookController.getBook);
    this.router.post("/book", bookController.newBook);
    this.router.put("/book/:id", bookController.updateBook);
    this.router.delete("/book/:id", bookController.deleteBook);
  }

  public getRoutes() {
    return this.router.routes();
  }

  public allowedMethods() {
    return this.router.allowedMethods();
  }
}
