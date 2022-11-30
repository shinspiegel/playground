import { DB } from "$sqlite/mod.ts";
import { database } from "./database.ts";

export class RepositoryError extends Error {
  constructor(message: string, repositoryName: string = "unknown repository") {
    super(`${message}, ${repositoryName}`);
  }
}

export class RepositoryEntryNotFound extends RepositoryError {
  constructor(repositoryName: string) {
    super("Entry not found in the database.", repositoryName);
  }
}

export class RepositoryFailedToInsert extends RepositoryError {
  constructor(repositoryName: string) {
    super("Entry failed to insert into.", repositoryName);
  }
}

export class RepositoryInitializationFailed extends RepositoryError {
  constructor(repositoryName: string) {
    super("Failed to initialize repository.", repositoryName);
  }
}

type RepositoryInit = {
  db?: DB;
  tableName: string;
};

export abstract class Repository<T> {
  protected tableName: string;

  abstract rowToModel(row: any): T;
  abstract createTable(): Promise<void>;
  abstract seed(): Promise<void>;
  abstract migrate(): Promise<void>;

  private _database: DB;

  constructor({ tableName, db = database }: RepositoryInit) {
    this._database = db;
    this.tableName = tableName;
    this._init();
  }

  private _init() {
    Promise.all([this.createTable(), this.seed(), this.migrate()]).catch((err) => {
      console.error("Failed to initialize repository");
      console.error(err);
      throw new RepositoryInitializationFailed(this.tableName);
    });
  }

  async execute(query: string): Promise<void> {
    await this._database.execute(query);
  }

  async getFirst(model: Partial<T>): Promise<T> {
    const values: any[] = Object.values(model);
    const where = Object.keys(model)
      .map((key) => `${key}=?`)
      .join(" AND ");

    const query = `SELECT * FROM ${this.tableName} WHERE ${where}`;
    const row = this._database.query(query, values)[0];

    if (!row) {
      throw new RepositoryEntryNotFound(this.tableName);
    }

    return this.rowToModel(row);
  }

  async getOneById(_id: number): Promise<T> {
    const query = `SELECT * FROM ${this.tableName} WHERE id = ?`;
    const row = this._database.query(query, [_id])[0];

    if (!row) {
      throw new RepositoryEntryNotFound(this.tableName);
    }

    return this.rowToModel(row);
  }

  async getAll(): Promise<T[]> {
    const query = `SELECT * FROM ${this.tableName}`;
    const list = this._database.query(query);
    return list.map((row) => this.rowToModel(row));
  }

  async insertOne(insert: Partial<T>) {
    const columns = Object.keys(insert).join(",");
    const placeholders = Object.keys(insert)
      .map((_) => `?`)
      .join(",");
    const values: any[] = Object.values(insert);
    const query = `INSERT INTO ${this.tableName} (${columns}) VALUES (${placeholders}) RETURNING *`;

    const row = this._database.query(query, values)[0];

    if (!row) {
      throw new RepositoryFailedToInsert(`Failed to insert into ${this.tableName}`);
    }

    return this.rowToModel(row);
  }

  updateOne(updated: Partial<T>): Promise<T> {
    throw new Error("Not implemented yet");
  }

  deleteOneById(id: number): Promise<void> {
    throw new Error("Not implemented yet");
  }
}
