import { Router } from 'express';
import bankController from './controllers/bookController';

const routes = Router();

/**
 * Routes for account controll
 */
routes.get(`/books`, bankController.index);
routes.get(`/books/:id`, bankController.index);
routes.post(`/books`, bankController.create);
routes.put(`/books/:id`, bankController.update);
routes.delete(`/books/:id`, bankController.destroy);

export default routes;
