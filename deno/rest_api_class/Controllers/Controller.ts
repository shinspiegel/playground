import { IModel } from "/Models/Model.ts";
import { IRepository } from "/Repository/Repository.ts";

export abstract class Controller<MODEL extends IModel> {
  protected repo: IRepository<MODEL>;

  constructor(repo: IRepository<MODEL>) {
    this.repo = repo;
  }
}
