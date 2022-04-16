import User from "../model/UserModel";
import { v4 } from "uuid";
import ServerError from "../ServerError";
import Repository from "./Repository";

export default class UserRepository extends Repository {
  static async show(): Promise<User[]> {
    const query = `MATCH (u: User) RETURN u`;
    const result = await UserRepository.query<User>(query);
    return result;
  }

  static async index(id: string): Promise<User> {
    const query = `MATCH (u: User{id: $id}) RETURN u`;
    const result = await UserRepository.query<User>(query, { id });
    return result[0];
  }

  static async create({ name, email, password }: Partial<User>): Promise<User> {
    await UserRepository.checkForEmail(email);
    const fields = ["name", "email", "password"];
    UserRepository.validate({ name, email, password }, fields);

    const id = v4();

    const query = `CREATE (u: User{ id: $id, name: $name, email: $email, password: $password}) RETURN u`;

    const result = await UserRepository.query<User>(query, {
      id,
      name,
      email,
      password,
    });

    return result[0];
  }

  static async update(
    id: string,
    { name, email }: Partial<User>
  ): Promise<User> {
    UserRepository.validate({ id }, ["id"]);
    const query = `MATCH (u: User{ id: $id}) SET u.name=$name, u.email=$email RETURN u`;
    const result = await UserRepository.query<User>(query, { id, name, email });
    return result[0];
  }

  static async delete(id: string): Promise<User> {
    const query = `MATCH (u: User{ id: $id}) DETACH DELETE u RETURN u`;
    const result = await UserRepository.query<User>(query, { id });
    return result[0];
  }

  static async getByEmail(email: string) {
    const query = `MATCH (u: User{  email: $email}) RETURN u`;
    const result = await UserRepository.query<User>(query, { email });
    return result;
  }

  private static async checkForEmail(email: string | undefined) {
    if (!email) {
      throw new ServerError({ message: "Empty email field", httpStatus: 406 });
    }

    const result = await UserRepository.getByEmail(email);

    if (result.length > 0) {
      throw new ServerError({
        message: "Email already in use",
        httpStatus: 406,
      });
    }
  }
}
