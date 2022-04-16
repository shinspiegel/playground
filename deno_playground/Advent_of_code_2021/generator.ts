import { ensureFileSync } from "./deps.ts";

const path = Deno.args[0];

ensureFileSync(`day_${path}/mod.ts`);
ensureFileSync(`day_${path}/sample`);
ensureFileSync(`day_${path}/input`);
