import { Handlers, PageProps } from "$fresh/server.ts";
import { parseTextPlain } from "../utils/parseTextPlain.ts";

const NAMES = ["Alice", "Bob", "Charlie", "Dave", "Eve", "Frank"];

interface Data {
  results: string[];
  query?: string;
}

export const handler: Handlers<Data> = {
  GET(req, ctx) {
    console.log(req.url);
    return ctx.render({ results: NAMES });
  },

  async POST(req, ctx) {
    const formData = await req.formData();
    const name = formData.get("name");

    if (name && typeof name === "string") {
      return ctx.render({ results: NAMES.filter((item) => item === name) });
    }

    return ctx.render({ results: NAMES });
  },
};

export default function Page({ data: { query, results } }: PageProps<Data>) {
  return (
    <div>
      <form action="/search" method="POST">
        <input type="text" name="name" value={query} />
        <button type="submit">Search</button>
      </form>
      <ul>
        {results.map((name) => (
          <li key={name}>{name}</li>
        ))}
      </ul>
    </div>
  );
}
