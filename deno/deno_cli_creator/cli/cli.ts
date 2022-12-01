import { parse } from "https://deno.land/std@0.119.0/flags/mod.ts";

const flags = parse(Deno.args, {
  boolean: ["generate", "init", "start"],
  alias: {
    generate: ["g"],
    help: ["h"],
    start: ["s"],
  },
});
