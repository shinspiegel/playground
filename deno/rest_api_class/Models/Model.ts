export interface IModel {
  id?: number;
  fromRow(row: unknown): unknown;
}
