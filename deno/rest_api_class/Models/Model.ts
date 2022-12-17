import { IModel } from "/Models/Model.interface.ts";
import {
  ModelInvalidBodyError,
  ModelInvalidBodyKey,
  ModelInvalidRowError,
  ModelNonExistingIndexesError,
} from "/Models/Model.errors.ts";

export abstract class Model implements IModel {
  public databaseIndexes?: string[] = ["id"];
  public id?: number | undefined;

  public validate(body: unknown) {
    if (!this.databaseIndexes) {
      throw new ModelNonExistingIndexesError();
    }

    if (!body || typeof body !== "object") {
      throw new ModelInvalidBodyError();
    }

    const errors: string[] = [];
    const bodyKeys = Object.keys(body);

    bodyKeys.forEach((key) => {
      if (!this.databaseIndexes?.includes(key)) {
        errors.push(key);
      }
    });

    if (errors.length > 0) {
      throw new ModelInvalidBodyKey(errors, this.databaseIndexes);
    }
  }

  public build(row: unknown): Model {
    if (!row || !Array.isArray(row)) {
      throw new ModelInvalidRowError();
    }

    if (!this.databaseIndexes) {
      throw new ModelNonExistingIndexesError();
    }

    this.databaseIndexes.forEach((key, i) => {
      this[key as keyof this] = row[i];
    });

    delete this.databaseIndexes;

    return this;
  }
}
