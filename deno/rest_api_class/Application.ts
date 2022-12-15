import { Application as OakApp } from "oak/mod.ts";
import { Env } from "/Env/Env.ts";
import { AppRoutes } from "/Router/AppRoutes.ts";

export class Application {
  private app: OakApp;
  private appRoutes: AppRoutes;

  constructor() {
    this.app = new OakApp();
    this.appRoutes = new AppRoutes();

    this.app.use(this.appRoutes.getRoutes());
    this.app.use(this.appRoutes.allowedMethods());
  }

  public getApp() {
    return this.app;
  }

  public async listen() {
    const env = new Env();
    console.log(`Running on port [${env.PORT}]`);
    await this.app.listen({ port: env.PORT });
  }
}
