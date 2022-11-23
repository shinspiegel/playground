import { Database, DataTypes, Model, Relationships, SQLite3Connector } from "denodb";

const connector = new SQLite3Connector({
  filepath: "./database.sqlite",
});

const db = new Database(connector);

class Owner extends Model {
  static table = "owners";

  static fields = {
    id: {
      type: DataTypes.STRING,
      primaryKey: true,
    },
    name: DataTypes.STRING,
  };

  static businesses() {
    return this.hasMany(Business);
  }
}

class Business extends Model {
  static table = "businesses";

  static fields = {
    id: {
      type: DataTypes.STRING,
      primaryKey: true,
    },
    name: DataTypes.STRING,
  };

  static owner() {
    return this.hasOne(Owner);
  }
}

Relationships.belongsTo(Business, Owner);

db.link([Owner, Business]);

await db.sync({ drop: true });

await Owner.create({
  id: "1",
  name: "John",
});

await Business.create({
  id: "1",
  name: "Parisian Café",
  ownerId: "1",
});

await Business.create({
  id: "2",
  name: "Something About Us",
  ownerId: "1",
});

console.log(await Owner.where("id", "1").businesses());
console.log(await Business.where("id", "1").owner());
console.log(await Business.where("id", "2").owner());

await db.close();
