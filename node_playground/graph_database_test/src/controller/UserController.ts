import { Request, Response } from "express";
import Controller from "./Controller";
import DefaultResponse from "../DefaultResponse";
import UserService from "../service/UserService";
import User from "../model/UserModel";

export default class UserController extends Controller {
  async show(req: Request, res: Response): Promise<void> {
    const message = new DefaultResponse<User>();

    try {
      message.data = await UserService.show();
      res.json(message);
    } catch (err) {
      message.success = false;
      message.message = err.message || "Unknown Error";
      message.data = [];
      res.status(err.httpStatus || 500).json(message);
    }
  }

  async index(req: Request, res: Response): Promise<void> {
    const message = new DefaultResponse<User>();

    try {
      message.data = [await UserService.index(req)];
      res.json(message);
    } catch (err) {
      message.success = false;
      message.message = err.message || "Unknown Error";
      message.data = [];
      res.status(err.httpStatus || 500).json(message);
    }
  }

  async create(req: Request, res: Response): Promise<void> {
    const message = new DefaultResponse<User>();

    try {
      message.data = await UserService.create(req);
      res.json(message);
    } catch (err) {
      message.success = false;
      message.message = err.message || "Unknown Error";
      message.data = [];
      res.status(err.httpStatus || 500).json(message);
    }
  }

  async update(req: Request, res: Response): Promise<void> {
    const message = new DefaultResponse<User>();

    try {
      message.data = [await UserService.update(req)];
      res.json(message);
    } catch (err) {
      message.success = false;
      message.message = err.message || "Unknown Error";
      message.data = [];
      res.status(err.httpStatus || 500).json(message);
    }
  }

  async delete(req: Request, res: Response): Promise<void> {
    const message = new DefaultResponse<User>();

    try {
      message.data = [await UserService.delete(req)];
      res.json(message);
    } catch (err) {
      message.success = false;
      message.message = err.message || "Unknown Error";
      message.data = [];
      res.status(err.httpStatus || 500).json(message);
    }
  }
}
