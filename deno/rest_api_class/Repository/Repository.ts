import { Client } from "postgres/mod.ts";
import { QueryArguments, QueryArrayResult } from "postgres/query/query.ts";
import {
  RepositoryError,
  RepositoryInvalidEntry,
  RepositoryMissingIdError,
  RepositoryNoEntryCreatedError,
} from "/Repository/Repository.errors.ts";
import { IRepository } from "/Repository/Repository.interface.ts";
import { client } from "/Database/client.ts";
import { IModel } from "/Models/Model.ts";

export abstract class Repository<MODEL extends IModel> implements IRepository<MODEL> {
  abstract createTable(): Promise<void>;
  abstract seed(): Promise<void>;
  abstract migrate(): Promise<void>;

  protected tableName: string;
  private database: Client;
  private model: new () => MODEL;

  constructor(tableName: string, model: new () => MODEL, database: Client = client) {
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

  async query<ROW extends Array<unknown>>(query: string, params?: QueryArguments): Promise<QueryArrayResult<ROW>> {
    return await this.database.queryArray(query, params);
  }

  private convertRowToModel(row: unknown): MODEL {
    return new this.model().fromRow(row) as MODEL;
  }

  private validateEntry(entry: Partial<MODEL>) {
    if (Object.keys(entry).length <= 0) {
      throw new RepositoryInvalidEntry();
    }
  }

  private validateEntryForId(entry: Partial<MODEL>) {
    if (!entry.id) {
      throw new RepositoryMissingIdError();
    }
  }

  async insertOne(entry: Partial<MODEL>): Promise<MODEL> {
    this.validateEntry(entry);

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

  async getAll(): Promise<MODEL[]> {
    const query = `SELECT * FROM ${this.tableName}`;
    const response = await this.query(query);
    return response.rows.map((row) => this.convertRowToModel(row));
  }

  async getOneBy(entry: Partial<MODEL>): Promise<MODEL> {
    this.validateEntry(entry);

    const keys = Object.keys(entry);
    const values = Object.values(entry);
    const query = `
      SELECT * FROM ${this.tableName}
      WHERE ${keys.map((key) => `${key}=$1`).join(" AND ")}
    `;

    const response = await this.query(query, values);

    if (response.rows.length <= 0) {
      throw new RepositoryNoEntryCreatedError(this.tableName);
    }

    return this.convertRowToModel(response.rows[0]);
  }

  async updateById(entry: Partial<MODEL>): Promise<MODEL> {
    this.validateEntry(entry);
    this.validateEntryForId(entry);

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
      throw new RepositoryNoEntryCreatedError(this.tableName);
    }

    return this.convertRowToModel(response.rows[0]);
  }

  async deleteById(entry: Partial<MODEL>): Promise<MODEL> {
    this.validateEntry(entry);
    this.validateEntryForId(entry);

    const query = `
      DELETE FROM ${this.tableName}
      WHERE id = $1
      RETURNING *;
    `;

    const response = await this.query(query, [entry.id]);

    if (response.rows.length <= 0) {
      throw new RepositoryNoEntryCreatedError(this.tableName);
    }

    return this.convertRowToModel(response.rows[0]);
  }
}
