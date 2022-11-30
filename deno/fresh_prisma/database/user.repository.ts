import { Repository } from "./repository.ts";
import { UserModel } from "./user.model.ts";

export class UserRepository extends Repository<UserModel> {
  constructor() {
    super({ tableName: "users" });
  }

  async createTable() {
    // const test = `DROP TABLE IF EXISTS ${this.tableName}`;
    // this.execute(test);

    const query = `
      CREATE TABLE IF NOT EXISTS ${this.tableName} (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        username TEXT,
        password TEXT
      )`;

    this.execute(query);
  }

  async seed() {}

  async migrate() {}

  rowToModel([id, name, password]: [id: number, name: string, password: string]): UserModel {
    return new UserModel(id, name, password);
  }
}
