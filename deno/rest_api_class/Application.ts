import { Application } from "oak/mod.ts";
import { router } from "./Router.ts";

export const app = new Application();
app.use(router.routes());
app.use(router.allowedMethods());
