import { Database, PostgresConnector } from "denodb";
import { Role } from "./models/role.ts";
import { User } from "./models/user.ts";

// const connector = new SQLite3Connector({
//   filepath: "./database.sqlite",
// });

const connector = new PostgresConnector({
  database: "postgres",
  host: "localhost",
  username: "postgres",
  password: "postgres",
  port: 5432,
});

export const db = new Database(connector);

db.link([Role, User]);
db.sync({ drop: true });

// await Role.seed();

// const adminRole = await Role.getAdminRole();

// User.create([{ name: "Admin", roleId: adminRole.id as string }]);
