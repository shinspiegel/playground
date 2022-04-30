import { Request, Response } from "express";
import DefaultResponse from "../DefaultResponse";

export default interface iController {
  index(req: Request, res: Response): void;
  show(req: Request, res: Response): void;
  create(req: Request, res: Response): void;
  update(req: Request, res: Response): void;
  delete(req: Request, res: Response): void;
}

export default class Controller implements iController {
  index(req: Request, res: Response) {
    const message = new DefaultResponse<any>();
    message.success = false;
    message.data = [];
    message.message =
      "This method is not implement or does not exist in this route.";
    res.status(405).json(message);
  }

  show(req: Request, res: Response) {
    const message = new DefaultResponse<any>();
    message.success = false;
    message.data = [];
    message.message =
      "This method is not implement or does not exist in this route.";
    res.status(405).json(message);
  }

  create(req: Request, res: Response) {
    const message = new DefaultResponse<any>();
    message.success = false;
    message.data = [];
    message.message =
      "This method is not implement or does not exist in this route.";
    res.status(405).json(message);
  }

  update(req: Request, res: Response) {
    const message = new DefaultResponse<any>();
    message.success = false;
    message.data = [];
    message.message =
      "This method is not implement or does not exist in this route.";
    res.status(405).json(message);
  }

  delete(req: Request, res: Response) {
    const message = new DefaultResponse<any>();
    message.success = false;
    message.data = [];
    message.message =
      "This method is not implement or does not exist in this route.";
    res.status(405).json(message);
  }
}
