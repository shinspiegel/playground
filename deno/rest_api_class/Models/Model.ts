import { IModel } from "/Models/Model.interface.ts";
import { ModelInvalidRowError } from "/Models/Model.errors.ts";

export abstract class Model implements IModel {
  public indexes: string[] = ["id"];
  public id?: number | undefined;

  public build(row: unknown): Model {
    if (!row || !Array.isArray(row)) {
      throw new ModelInvalidRowError();
    }

    this.indexes.forEach((key, i) => {
      this[key as keyof this] = row[i];
    });

    return this;
  }
}
