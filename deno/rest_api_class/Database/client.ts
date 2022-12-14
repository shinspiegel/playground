import { Client } from "postgres/mod.ts";
import { Env } from "/Env/env.ts";

const env = new Env();

export const client: Client = new Client({
  user: env.DB_USER,
  password: env.DB_PASS,
  database: env.DB_DATA,
  hostname: env.DB_HOST,
  port: env.DB_PORT,
});
