import { Router } from "../deps.ts";
import Planet from "../models/planet.ts";

const routes = new Router({ prefix: "/api" });

routes.get("/", (ctx) => {
    ctx.response.body = "heeeloo";
});

routes.get("/shit", async (ctx) => {
    ctx.response.body = await Planet.getPlanets();
});

export default routes;
