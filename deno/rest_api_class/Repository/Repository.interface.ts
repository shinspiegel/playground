import { QueryArguments, QueryArrayResult } from "postgres/query/query.ts";
import { IModel } from "/Models/Model.interface.ts";

export interface IRepository<MODEL extends IModel> {
  createTable(): Promise<void>;
  seed(): Promise<void>;
  migrate(): Promise<void>;
  query<ROW extends Array<unknown>>(
    query: string,
    params?: QueryArguments,
  ): Promise<QueryArrayResult<ROW>>;
  insertOne(entry: Partial<MODEL>): Promise<MODEL>;
  getAll(): Promise<MODEL[]>;
  getOneBy(entry: Partial<MODEL>): Promise<MODEL>;
  updateById(entry: Partial<MODEL>): Promise<MODEL>;
  deleteById(entry: Partial<MODEL>): Promise<MODEL>;
}
