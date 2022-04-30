import { Application, path, send } from "./deps.ts";
import logger from "./src/logger.ts";
import routes from "./src/routes.ts";

const app = new Application();
const port = 8000;

app.use(async ({ request, response }, next) => {
  logger.info(`[${request.method}] ${request.url}`);
  const timeStart = new Date().getTime();

  await next();

  const timeFinish = new Date().getTime();
  response.headers.set("X-Request-Time", `${timeStart - timeFinish}ms`);
});

app.use(routes.routes());
app.use(routes.allowedMethods());

app.use(async (ctx) => {
  const filePath = ctx.request.url.pathname;
  await send(ctx, filePath, {
    index: "index.html",
    root: path.join(Deno.cwd(), "public"),
  });
});

await app.listen({ port });
logger.info("Server started");
