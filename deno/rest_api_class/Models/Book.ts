import { Model } from "/Models/Model.ts";

export class Book extends Model {
  public databaseIndexes: string[] = ["id", "name", "isbn"];

  public name?: string;
  public isbn?: string;
}
