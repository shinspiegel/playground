import { ServiceIdNotNumber } from "/Service/Service.errors.ts";
import { IModel } from "/Models/Model.interface.ts";
import { IRepository } from "/Repository/Repository.interface.ts";
import { IService } from "/Service/Service.interface.ts";

export abstract class Service<MODEL extends IModel> implements IService<MODEL> {
  public repo: IRepository<MODEL>;
  public model: new () => MODEL;

  constructor(repo: IRepository<MODEL>, model: new () => MODEL) {
    this.repo = repo;
    this.model = model;
  }

  validateBody(body: unknown) {
    const model = new this.model();
    model.validate(body);
  }

  getAll(): Promise<MODEL[]> {
    return this.repo.getAll();
  }

  getById(id: string): Promise<MODEL> {
    const model = new this.model();
    const modelId = Number(id);

    if (Number.isNaN(modelId)) {
      throw new ServiceIdNotNumber();
    }

    model.id = modelId;

    return this.repo.getOneBy(model);
  }

  create(model: Partial<MODEL>): Promise<MODEL> {
    this.validateBody(model);
    return this.repo.insertOne(model);
  }

  update(id: string, model: Partial<MODEL>): Promise<MODEL> {
    const modelId = Number(id);

    if (Number.isNaN(modelId)) {
      throw new ServiceIdNotNumber();
    }

    model.id = modelId;

    this.validateBody(model);
    return this.repo.updateById(model);
  }

  deleteById(id: string): Promise<MODEL> {
    const model = new this.model();
    const modelId = Number(id);

    if (Number.isNaN(modelId)) {
      throw new ServiceIdNotNumber();
    }

    model.id = modelId;

    return this.repo.deleteById(model);
  }
}
