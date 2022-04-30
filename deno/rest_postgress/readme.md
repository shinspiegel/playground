# Deno API with Postgress

This a practice project to create a integration between postgress and Deno application using OAK framework. This is a very simple yet very surprising application.

Before running this application, create a SECRET.ts file on the root on this applications following the exemple:

```ts
//SECRET.ts
export const POSTGRESS_URI = "a uri for a postgresql database"; // This is the mongo URI as string
```

```sh
deno run --allow-net index.ts
```

As a REST api it will need `allow-net` flag.
