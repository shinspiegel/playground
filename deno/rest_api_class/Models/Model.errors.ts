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
