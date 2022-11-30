import { Handlers, PageProps } from "$fresh/server.ts";
import { Head } from "$fresh/runtime.ts";
import { UserModel } from "../database/user.model.ts";
import { UserRepository } from "../database/user.repository.ts";
import Counter from "../islands/Counter.tsx";
import LoginForm from "../islands/LoginForm.tsx";

export const handler: Handlers<UserModel> = {
  async GET(req, ctx) {
    const resp = await ctx.render();
    resp.headers.set("Set-Cookie", "jwt=random_data");
    return resp;
  },
};

export default function Home() {
  return (
    <>
      <Head>
        <title>Fresh App</title>
      </Head>
      <div>
        <img src="/logo.svg" width="128" height="128" alt="the fresh logo: a sliced lemon dripping with juice" />
        <p>Welcome to `fresh`. Try updating this message in the ./routes/index.tsx file, and refresh.</p>
        <Counter start={3} />
        <LoginForm />
      </div>
    </>
  );
}
