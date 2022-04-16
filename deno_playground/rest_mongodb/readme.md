# Deno API with mongoDB

This a practice project to create a integration between mongodb and Deno application using OAK framework. This is a very simple yet very surprising application.

Before running this application, create a SECRET.ts file on the root on this applications following the exemple:

```ts
//SECRET.ts
export const MONGO_URI = "mongoURI"; // This is the mongo URI as string
```

To run this app just use the following, it will download the binary plugin for `deno_mongo`, so be patiente.

```sh
deno run --allow-net --allow-write --allow-read --allow-plugin --unstable index.ts
```

As a REST api it will need `allow-net` flag. MongoDB need the rest of the flags.
