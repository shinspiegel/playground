import { Client } from "https://deno.land/x/postgres/mod.ts";
import { Column } from "https://deno.land/x/postgres/connection.ts";
import { QueryResult } from "https://deno.land/x/postgres/query.ts";
import { POSTGRESS_URI } from "../SECRET.ts";

type mixedType = string | boolean;

const client = new Client(POSTGRESS_URI);

export async function query(text: string, args?: mixedType[]) {
  await client.connect();

  let result: QueryResult;

  if (args) {
    result = await client.query({ text, args });
  } else {
    result = await client.query({ text });
  }

  await client.end();

  return result;
}

export function generateJson(rowsList: any[], columnsList: Column[]) {
  const jsonObject = rowsList.map((row: any[]) => {
    let rowObject: any = {};

    row.flat().map((item: any, i: number) =>
      rowObject[columnsList[i].name] = item
    );

    return rowObject;
  });

  return jsonObject;
}

export async function createTables() {
  await client.connect();

  await client.query(
    "CREATE TABLE IF NOT EXISTS denoUsers ( id uuid PRIMARY KEY DEFAULT uuid_generate_v4(), name VARCHAR, email VARCHAR UNIQUE, isActive BOOLEAN DEFAULT TRUE);",
  );

  await client.end();
  console.log("[DATABASE] - table created");
}
