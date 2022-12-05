export class ModelError extends Error {
  constructor(msg: string) {
    super(msg);
  }
}

export class ModelErrorMethodNotImplemented extends ModelError {
  constructor() {
    super("Model 'fromRow' not implemented.");
  }
}

export abstract class Model {
  public id?: number;

  abstract fromRow(row: unknown): unknown;
}
