export class ServiceError extends Error {
  constructor(msg: string) {
    super(msg);
  }
}

export class ServiceIdNotNumberError extends ServiceError {
  constructor() {
    super("Id param is not a number");
  }
}
