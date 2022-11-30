import { Head } from "$fresh/runtime.ts";
import { Handlers, PageProps } from "$fresh/server.ts";

export const handler: Handlers = {
  async GET(req, ctx) {
    const form = req.headers.get("x-form-invalid");
    const body = JSON.stringify(req.body);

    console.log({ form, body });

    return ctx.render();
  },
};

export default function Home({ data }: PageProps) {
  return (
    <>
      <Head>
        <title>Fresh App</title>
      </Head>
      <div>
        <form action="/login" encType="multipart/form-data" method="POST">
          <label>
            username
            <input name="username" />
          </label>
          <label>
            password
            <input name="password" type="password" />
          </label>
          <button type="submit">Login</button>
        </form>
      </div>
    </>
  );
}
