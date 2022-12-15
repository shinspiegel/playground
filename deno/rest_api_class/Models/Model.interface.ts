export interface IModel {
  id?: number;
  build(row: unknown): IModel;
}
