import { Router } from "https://deno.land/x/oak/mod.ts";
import userController from "./controller/userController.ts";

const router = new Router();

router.get("/api/v1/users", userController.index);
router.get("/api/v1/users/:id", userController.index);
router.post("/api/v1/users", userController.create);
router.put("/api/v1/users/:id", userController.update);
router.delete("/api/v1/users/:id", userController.destroy);

export default router;
