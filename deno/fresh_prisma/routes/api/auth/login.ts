import { Handlers } from "$fresh/server.ts";
import { RepositoryEntryNotFound } from "../../../database/repository.ts";
import { UserRepository } from "../../../database/user.repository.ts";
import { sanitizeJson, SanitizeJsonError } from "../../../utils/sanitizeJson.ts";

export const handler: Handlers = {
  async POST(req, _ctx) {
    try {
      const { username, password } = sanitizeJson(await req.text(), [{ name: "username" }, { name: "password" }]);
      const userRepo = new UserRepository();
      const user = await userRepo.getFirst({ username, password });
      return new Response(JSON.stringify(user));
    } catch (error) {
      if (error instanceof SanitizeJsonError) {
        return new Response(JSON.stringify({ error }), { status: 400 });
      }

      if (error instanceof RepositoryEntryNotFound) {
        return new Response(JSON.stringify({ error }), { status: 404 });
      }

      return new Response(JSON.stringify({ error }), { status: 500 });
    }
  },
};
