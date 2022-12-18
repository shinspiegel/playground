import { IModel } from "/Models/Model.interface.ts";

export class Book implements IModel {
  public id?: number;
  public name?: string;
  public isbn?: string;
}
