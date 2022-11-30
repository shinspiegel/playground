import { Handlers } from "$fresh/server.ts";

export const handler: Handlers = {
  async POST(req, ctx) {
    const formData = await req.formData();
    const username = formData.get("username");
    const password = formData.get("password");

    const isValid = false;

    if (!isValid) {
      const location = new URL(req.url);
      location.pathname = "/";

      const headers = new Headers({
        location: location.href,
        "x-form-invalid": "Invalid",
      });

      return new Response(JSON.stringify({ form: false }), {
        status: 302,
        headers,
      });
    }

    const location = new URL(req.url);
    location.pathname = "/dashboard";

    const headers = new Headers({
      location: location.href,
    });

    return new Response(null, {
      status: 302,
      headers,
    });
  },
};
