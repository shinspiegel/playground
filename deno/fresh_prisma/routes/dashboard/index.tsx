import { Head } from "$fresh/runtime.ts";
import { Handlers } from "$fresh/server.ts";

export const handler: Handlers = {
  async GET(req, ctx) {
    console.log("aaaa");

    return await ctx.render();
  },
};

export default function Home() {
  return (
    <>
      <Head>
        <title>Dashboard</title>
      </Head>
      <div>
        <h1>Dashboard</h1>
      </div>
    </>
  );
}
