type serverErrorOptions = { message?: string; httpStatus?: number };

export default class ServerError extends Error {
  public httpStatus: number = 500;
  constructor({
    message = "Unknown error",
    httpStatus = 500,
  }: serverErrorOptions = {}) {
    super(message);
    this.httpStatus = httpStatus;
  }
}
