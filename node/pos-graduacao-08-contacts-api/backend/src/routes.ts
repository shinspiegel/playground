import { Router } from 'express';
import contactsController from './controllers/contactController';

const routes = Router();

/**
 * Routes for account controll
 */
routes.get(`/contacts`, contactsController.index);
routes.get(`/contacts/:id`, contactsController.index);
routes.post(`/contacts`, contactsController.create);
routes.put(`/contacts/:id`, contactsController.update);
routes.delete(`/contacts/:id`, contactsController.destroy);

export default routes;
