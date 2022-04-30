import { MongoClient } from "https://deno.land/x/mongo/mod.ts";
import { MONGO_URI } from "../SECRET.ts";

const client = new MongoClient();

client.connectWithUri(MONGO_URI);

export const db = client.database("deno_mongo");
export const Users = db.collection("mongoUsers");
