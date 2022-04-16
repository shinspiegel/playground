import { Application } from "https://deno.land/x/oak/mod.ts";
import router from "./routes.ts";
import { createTables } from "./database/database.ts";

createTables();

const app = new Application();

app.use(router.routes());
app.use(router.allowedMethods());

app.listen({ port: 8000 });
console.log("server running");
