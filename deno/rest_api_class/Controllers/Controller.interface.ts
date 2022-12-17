import { RouterContext } from "oak/mod.ts";
import { IService } from "/Service/Service.interface.ts";
import { IModel } from "/Models/Model.interface.ts";

type ControllerReturn = Promise<void> | void;

export interface IController<MODEL extends IModel> {
  service: IService<MODEL>;
  raiseError: (context: RouterContext<any>, error: unknown) => ControllerReturn;
  post: (context: RouterContext<any>) => ControllerReturn;
  get: (context: RouterContext<any>) => ControllerReturn;
  show: (context: RouterContext<any>) => ControllerReturn;
  put: (context: RouterContext<any>) => ControllerReturn;
  delete: (context: RouterContext<any>) => ControllerReturn;
}
