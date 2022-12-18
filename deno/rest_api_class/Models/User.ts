import { IModel } from "/Models/Model.interface.ts";

export class User implements IModel {
  public id?: number;
  public username?: string;
  public password?: string;
}
