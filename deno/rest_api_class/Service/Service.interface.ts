import { IRepository } from "/Repository/Repository.interface.ts";
import { IModel } from "/Models/Model.interface.ts";

export interface IService<MODEL extends IModel> {
  repo: IRepository<MODEL>;
  getAll(): Promise<MODEL[]>;
  getById(id: string): Promise<MODEL>;
  create(model: Partial<MODEL>): Promise<MODEL>;
  update(id: string, model: Partial<MODEL>): Promise<MODEL>;
  deleteById(id: string): Promise<MODEL>;
}
