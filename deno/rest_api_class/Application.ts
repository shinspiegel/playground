import { Application } from "oak/mod.ts";
import { AppRoutes } from "/Router/AppRoutes.ts";

export const app = new Application();
const appRoutes = new AppRoutes();

app.use(appRoutes.getRoutes());
app.use(appRoutes.allowedMethods());
