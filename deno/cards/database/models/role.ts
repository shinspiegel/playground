import { Model, DataTypes } from "denodb";
import { ModelDefaults } from "https://deno.land/x/denodb@v1.1.0/lib/model.ts";
import { User } from "./user.ts";

export class Role extends Model {
  static table = "role";
  static timestamps = true;

  static fields = {
    id: { primaryKey: true, type: DataTypes.STRING },
    role: DataTypes.string(25),
  };

  static defaults: ModelDefaults = {
    id: crypto.randomUUID(),
  };

  static users() {
    return this.hasMany(User);
  }

  static getAdminRole() {
    return Role.findByRole("admin");
  }

  static getUserRole() {
    return Role.findByRole("admin");
  }

  static findByRole(role: string) {
    return this.where("role", "=", role).first();
  }

  static async seed() {
    if (!(await Role.findByRole("admin"))) {
      console.log("Creating 'admin' role.");
      Role.create([{ id: crypto.randomUUID(), role: "admin" }]);
    }

    if (!(await Role.findByRole("user"))) {
      console.log("Creating 'user' role.");
      Role.create([{ id: crypto.randomUUID(), role: "user" }]);
    }
  }
}
