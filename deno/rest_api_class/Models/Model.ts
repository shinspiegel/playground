import { IModel } from "/Models/Model.interface.ts";
import {
  ModelInvalidBodyError,
  ModelInvalidBodyKey,
  ModelInvalidRowError,
  ModelNonExistingIdError,
  ModelNonExistingIndexesError,
} from "/Models/Model.errors.ts";

export abstract class Model implements IModel {
  public databaseIndexes?: string[] = ["id"];
  public id?: number | undefined;

  public validateForId(body: unknown) {
    if (!body || typeof body !== "object") {
      throw new ModelInvalidBodyError();
    }

    if (!Object.prototype.hasOwnProperty.call(body, "id")) {
      throw new ModelNonExistingIdError();
    }

    return this;
  }

  public validate(body: unknown, fields: string[] | undefined = this.databaseIndexes) {
    if (!fields) {
      throw new ModelNonExistingIndexesError();
    }

    if (!body || typeof body !== "object") {
      throw new ModelInvalidBodyError();
    }

    const errors: string[] = [];

    if ("databaseIndexes" in body) {
      delete body.databaseIndexes;
    }

    const bodyKeys = Object.keys(body);

    bodyKeys.forEach((key) => {
      if (!fields.includes(key)) {
        errors.push(key);
      }
    });

    if (errors.length > 0) {
      throw new ModelInvalidBodyKey(errors, fields);
    }

    return this;
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
