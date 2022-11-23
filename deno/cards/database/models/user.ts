import { Model, DataTypes } from "denodb";
import { Role } from "./role.ts";

export class User extends Model {
  static table = "user";
  static timestamps = true;

  static fields = {
    id: { primaryKey: true, type: DataTypes.STRING },
    name: DataTypes.string(25),
  };

  static defaults = {
    id: crypto.randomUUID(),
  };

  static role() {
    return this.hasOne(Role);
  }
}
