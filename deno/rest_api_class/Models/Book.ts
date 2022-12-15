import { Model } from "/Models/Model.ts";

export class Book extends Model {
  public indexes: string[] = ["id", "name", "isbn"];

  public name?: string;
  public isbn?: string;
}
