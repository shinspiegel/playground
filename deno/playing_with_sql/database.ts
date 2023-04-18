import { DB, QueryParameterSet } from "https://deno.land/x/sqlite/mod.ts";

export class Database {
  static query(query: string, params?: QueryParameterSet) {
    const db = new DB("test.db");
    const data = db.query(query, params);
    db.close();
    return data;
  }
}
