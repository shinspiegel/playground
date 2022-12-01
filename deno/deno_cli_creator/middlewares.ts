import { Context } from "https://deno.land/x/oak/mod.ts";

type Ctx = Context<Record<string, any>>;
type NextFunction = () => Promise<unknown>;

export async function timing(ctx: Ctx, next: NextFunction) {
  const start = Date.now();
  await next();
  const ms = Date.now() - start;
  ctx.response.headers.set("X-Response-Time", `${ms}ms`);
}

export async function logger(ctx: Ctx, next: NextFunction) {
  await next();
  const rt = ctx.response.headers.get("X-Response-Time");
  console.log(`${ctx.request.method} ${ctx.request.url} - ${rt}`);
}
