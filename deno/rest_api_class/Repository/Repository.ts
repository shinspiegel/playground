import { _format } from "https://deno.land/std@0.160.0/path/_util.ts";
import { Client } from "https://deno.land/x/postgres@v0.17.0/mod.ts";
import { QueryArguments, QueryArrayResult } from "https://deno.land/x/postgres@v0.17.0/query/query.ts";
import { Model } from "../Models/Model.ts";

const client: Client = new Client({
  user: "postgres",
  password: "postgres",
  database: "postgres",
  hostname: "localhost",
  port: 5432,
});

export class RepositoryError extends Error {
  constructor(msg: string) {
    super(msg);
  }
}

export abstract class Repository<T extends Model> {
  abstract createTable(): Promise<void>;
  abstract seed(): Promise<void>;
  abstract migrate(): Promise<void>;

  protected tableName: string;
  private database: Client;
  private model: new () => T;

  constructor(tableName: string, model: new () => T, database: Client = client) {
    this.tableName = tableName;
    this.database = database;
    this.model = model;

    this.database.connect().then(() => {
      this.createTable().then(() => {
        this.migrate().then(() => {
          this.seed();
        });
      });
    }); // HATE THIS!
  }

  query<ROW extends Array<unknown>>(query: string, params?: QueryArguments): Promise<QueryArrayResult<ROW>> {
    return this.database.queryArray(query, params);
  }

  private convertRowToModel(row: unknown): T {
    return new this.model().fromRow(row) as T;
  }

  async insertOne(entry: Partial<T>): Promise<T> {
    const keys = Object.keys(entry);
    const values = Object.values(entry);
    const query = `
      INSERT INTO ${this.tableName} (${keys.join(",")})
      VALUES (${keys.map((_, i) => `$${i + 1}`).join(",")})
      RETURNING *
    `;

    const response = await this.query(query, values);

    if (response.rows.length <= 0) {
      throw new RepositoryError(`No entry created on ${this.tableName}`);
    }

    return this.convertRowToModel(response.rows[0]);
  }

  async getAll(): Promise<T[]> {
    const query = `SELECT * FROM ${this.tableName}`;
    const response = await this.query(query);
    return response.rows.map((row) => this.convertRowToModel(row));
  }

  async getOneBy(entry: Partial<T>): Promise<T> {
    const keys = Object.keys(entry);
    const values = Object.values(entry);
    const query = `
      SELECT * FROM ${this.tableName}
      WHERE ${keys.map((key) => `${key}=$1`).join(" AND ")}
    `;

    const response = await this.query(query, values);

    if (response.rows.length <= 0) {
      throw new RepositoryError(`No entry created on ${this.tableName}`);
    }

    return this.convertRowToModel(response.rows[0]);
  }

  async updateOne(entry: Partial<T>): Promise<T> {
    if (!entry.id) {
      throw new RepositoryError("Missing 'id' property on partial");
    }

    const id = entry.id;
    delete entry.id;

    const entries = Object.entries(entry).sort((a, b) => String(a[0]).localeCompare(String(b[0])));
    const keys = entries.map(([key]) => key);
    const values = entries.map(([_, value]) => value);

    const query = `
      UPDATE ${this.tableName}
      SET ${keys.map((key, i) => `${key}=$${i + 2}`).join(",")}
      WHERE id = $1
      RETURNING *;
    `;

    const response = await this.query(query, [id, ...values]);

    if (response.rows.length <= 0) {
      throw new RepositoryError(`No entry created on ${this.tableName}`);
    }

    return this.convertRowToModel(response.rows[0]);
  }

  async deleteOne(entry: Partial<T>): Promise<T> {
    if (!entry.id) {
      throw new RepositoryError("Missing 'id' property on partial");
    }

    const query = `
      DELETE FROM ${this.tableName}
      WHERE id = $1
      RETURNING *;
    `;

    const response = await this.query(query, [entry.id]);

    if (response.rows.length <= 0) {
      throw new RepositoryError(`No entry created on ${this.tableName}`);
    }

    return this.convertRowToModel(response.rows[0]);
  }
}
