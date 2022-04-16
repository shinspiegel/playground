import ServerError from "../ServerError";
import db from "./Database";

export default class Repository {
  static async query<T>(query: string, options?: Partial<T>) {
    const result: T[] = await db
      .run(query, options)
      .then((res) => res.records.map((r) => r.toObject()))
      .then((res) => res.map((r) => r.u.properties));

    return result;
  }

  static validate(body: any, fields: string[]) {
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
  }
}
