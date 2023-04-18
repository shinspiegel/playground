import { config } from "https://deno.land/x/dotenv/mod.ts";

Object.entries(config())



console.log("Env");
console.log(Deno.env.toObject());
