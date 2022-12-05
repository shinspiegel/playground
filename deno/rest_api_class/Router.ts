import { Router } from "https://deno.land/x/oak/mod.ts";
import { BookController } from "./Controllers/BookController.ts";

const bookController = new BookController();

export const router = new Router();

router.get("/book", bookController.getAll);
router.get("/book/:id", bookController.getBook);
router.post("/book", bookController.newBook);
router.put("/book/:id", bookController.updateBook);
router.delete("/book/:id", bookController.deleteBook);
