import ServerError from "../ServerError";

export default class Service {
  static validate<T>(body: any, fields: string[]): T {
    const errors: string[] = [];

    fields.forEach((field) => {
      if (!body[field]) errors.push(field);
    });

    if (errors.length > 0) {
      throw new ServerError({
        message: `Missing: ${errors.join(", ")}`,
        httpStatus: 406,
      });
    }

    return body as T;
  }
}
