import { IRepository } from "/Repository/Repository.interface.ts";
import { IModel } from "/Models/Model.ts";

export interface IService<MODEL extends IModel> {
  repo: IRepository<MODEL>;
  getAll(): Promise<MODEL[]>;
  getOne(model: Partial<MODEL>): Promise<MODEL>;
  create(model: Partial<MODEL>): Promise<MODEL>;
  update(model: Partial<MODEL>): Promise<MODEL>;
  delete(model: Partial<MODEL>): Promise<MODEL>;
}

export abstract class Service<MODEL extends IModel> implements IService<MODEL> {
  public repo: IRepository<MODEL>;

  constructor(repo: IRepository<MODEL>) {
    this.repo = repo;
  }

  getAll(): Promise<MODEL[]> {
    return this.repo.getAll();
  }

  getOne(model: Partial<MODEL>): Promise<MODEL> {
    return this.repo.getOneBy(model);
  }

  create(model: Partial<MODEL>): Promise<MODEL> {
    return this.repo.insertOne(model);
  }

  update(model: Partial<MODEL>): Promise<MODEL> {
    return this.repo.updateById(model);
  }

  delete(model: Partial<MODEL>): Promise<MODEL> {
    return this.repo.deleteById(model);
  }
}
