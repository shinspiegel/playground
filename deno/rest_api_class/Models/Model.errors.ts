export class ModelError extends Error {
  constructor(msg: string) {
    super(msg);
  }
}

export class ModelInvalidRowError extends ModelError {
  constructor() {
    super("Invalid or non-existent [row]");
  }
}

export class ModelNonExistingIndexesError extends ModelError {
  constructor() {
    super("Model indexes was not find. Please add model indexes for database parse.");
  }
}

export class ModelInvalidBodyError extends ModelError {
  constructor() {
    super("Invalid body shape for the model.");
  }
}

export class ModelInvalidBodyKey extends ModelError {
  constructor(keys: string[], shape: string[]) {
    super(`Properties does not match model. [${keys.join(", ")}]. \nThe possible ones are: [${shape.join(", ")}]`);
  }
}
