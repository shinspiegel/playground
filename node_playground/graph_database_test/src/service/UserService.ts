import { Request } from "express";
import User from "../model/UserModel";
import UserRepository from "../repository/UserRepository";
import ServerError from "../ServerError";
import Service from "./Service";

export default class UserService extends Service {
  static async show(): Promise<User[]> {
    return await UserRepository.show();
  }

  static async index(req: Request): Promise<User> {
    const fields = ["id"];
    const body = UserService.validate<User>(req.params, fields);
    const user = await UserRepository.index(body.id);
    return user;
  }

  static async create(req: Request): Promise<User[]> {
    const fields = ["name", "email", "password"];
    const body = UserService.validate<User>(req.body, fields);
    const user = await UserRepository.create(body);
    return [user];
  }

  static async update(req: Request): Promise<User> {
    const fields = ["name", "email"];
    const body = UserService.validate<User>(req.body, fields);
    const params = UserService.validate<User>(req.params, ["id"]);
    const user = await UserRepository.update(params.id, body);
    return user;
  }

  static async delete(req: Request): Promise<User> {
    const fields = ["id"];
    const body = UserService.validate<User>(req.params, fields);
    const user = await UserRepository.delete(body.id);
    return user;
  }
}
