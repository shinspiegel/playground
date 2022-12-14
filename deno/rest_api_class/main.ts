import { app } from "./Application.ts";
import { Env } from "./Env/env.ts";

const env = new Env();

console.log(`Running on port [${env.PORT}]`);
await app.listen({ port: env.PORT });
