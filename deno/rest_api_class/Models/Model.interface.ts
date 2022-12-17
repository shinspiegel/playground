export interface IModel {
  id?: number;
  databaseIndexes?: string[];
  build(row: unknown): IModel;
  validate(body: unknown): IModel;
  validateForId(body: unknown): IModel;
}
