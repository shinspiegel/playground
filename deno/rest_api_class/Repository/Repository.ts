import { Client } from "postgres/mod.ts";
import { QueryArguments, QueryObjectResult } from "postgres/query/query.ts";
import {
  RepositoryError,
  RepositoryInvalidDataEntry,
  RepositoryInvalidEntry,
  RepositoryMappedFailedError,
  RepositoryNoEntryCreatedError,
  RepositoryNoEntryDeletedError,
  RepositoryNoEntryUpdatedError,
} from "/Repository/Repository.errors.ts";
import { IRepository } from "/Repository/Repository.interface.ts";
import { client } from "/Database/client.ts";
import { IModel } from "/Models/Model.interface.ts";
import { Logger } from "../Logger/Logger.ts";

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

  public async query<ROW extends Array<unknown>>(
    query: string,
    params?: QueryArguments
  ): Promise<QueryObjectResult<ROW>> {
    Logger.debug(query, params);
    return await this.database.queryObject(query, params);
  }

  private toModel(row: unknown): MODEL {
    if (!row || typeof row !== "object") {
      throw new RepositoryInvalidDataEntry();
    }

    const model = new this.model();

    Object.keys(row).forEach((key) => {
      if (!Object.keys(model).includes(key)) {
        throw new RepositoryMappedFailedError();
      }

      // Will add the property inside the object.
      // deno-lint-ignore ban-ts-comment
      //@ts-ignore
      model[key] = row[key];
    });

    Logger.debug(model);
    return model;
  }

  private listToModel(rows: unknown[]): MODEL[] {
    if (!rows || !Array.isArray(rows)) {
      throw new RepositoryInvalidEntry();
    }

    return rows.map((row) => this.toModel(row));
  }

  async insertOne(entry: Partial<MODEL>): Promise<MODEL> {
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

    return this.toModel(response.rows[0]);
  }

  async getAll(): Promise<MODEL[]> {
    const query = `SELECT * FROM ${this.tableName}`;
    const response = await this.query(query);
    return this.listToModel(response.rows);
  }

  async getOneBy(entry: Partial<MODEL>): Promise<MODEL> {
    Object.keys(entry).forEach((key) => {
      // deno-lint-ignore ban-ts-comment
      //@ts-ignore
      if (entry[key] === undefined) {
        // deno-lint-ignore ban-ts-comment
        //@ts-ignore
        delete entry[key];
      }
    });

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

    return this.toModel(response.rows[0]);
  }

  async updateById(entry: Partial<MODEL>): Promise<MODEL> {
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
      throw new RepositoryNoEntryUpdatedError(this.tableName);
    }

    return this.toModel(response.rows[0]);
  }

  async deleteById(entry: Partial<MODEL>): Promise<MODEL> {
    const query = `
      DELETE FROM ${this.tableName}
      WHERE id = $1
      RETURNING *;
    `;

    const response = await this.query(query, [entry.id]);

    if (response.rows.length <= 0) {
      throw new RepositoryNoEntryDeletedError(this.tableName);
    }

    return this.toModel(response.rows[0]);
  }
}
