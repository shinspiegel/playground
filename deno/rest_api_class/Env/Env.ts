import { config } from "std/dotenv/mod.ts";
import { FailedToReadEnvError, NaNEnvError } from "/Env/Env.errors.ts";

const configData = await config();

export class Env {
  DB_USER: string;
  DB_PASS: string;
  DB_DATA: string;
  DB_HOST: string;
  DB_PORT: number;
  LOG_LEVEL: string;
  PORT: number;

  constructor() {
    this.DB_USER = this.get("DB_USER");
    this.DB_PASS = this.get("DB_PASS");
    this.DB_DATA = this.get("DB_DATA");
    this.DB_HOST = this.get("DB_HOST");
    this.DB_PORT = this.getNumber("DB_PORT");
    this.LOG_LEVEL = this.get("LOG_LEVEL");
    this.PORT = this.getNumber("PORT");
  }

  private getNumber(env: string) {
    const val = Number(this.get(env));

    if (Number.isNaN(val)) {
      throw new NaNEnvError(env);
    }

    return val;
  }

  private get(env: string) {
    const value = configData[env] || Deno.env.get(env);

    if (!value) {
      throw new FailedToReadEnvError(env);
    }

    return value;
  }
}
