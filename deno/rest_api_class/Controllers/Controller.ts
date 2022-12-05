import { Model } from "../Models/Model.ts";
import { Repository } from "../Repository/Repository.ts";

export class Controller<T extends Model, REPO extends Repository<T>> {
  protected repo: REPO;

  constructor(repo: REPO) {
    this.repo = repo;
  }
}
