import { Router } from "express";
import bankController from "./controllers/bankController";
import balanceController from "./controllers/balanceController";

const routes = Router();

/**
 * Routes for account controll
 */
routes.get(`/account`, bankController.index);
routes.get(`/account/:id`, bankController.index);
routes.post(`/account`, bankController.create);
routes.put(`/account/:id`, bankController.update);
routes.delete(`/account/:id`, bankController.destroy);

/**
 * Routes for balance controll
 */
routes.get(`/balance/:id`, bankController.index);
routes.post(`/balance/deposit/:id`, balanceController.deposit);
routes.post(`/balance/withdraw/:id`, balanceController.withdraw);

export default routes;
