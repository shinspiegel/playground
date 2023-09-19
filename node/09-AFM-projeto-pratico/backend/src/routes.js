const express = require('express');
const userController = require('./controllers/usersController');
const accessController = require('./controllers/accessController');
const companyController = require('./controllers/companyController');
const productsController = require('./controllers/productsController');

const routes = express.Router();

routes.get(`/test`, (req, res) => res.json({ ok: true }));
/**
 * Routes for user control
 */
routes.post(`/access/login`, accessController.login);
routes.post(`/access/register/`, accessController.register);

/**
 * Routes for user control
 */
routes.get(`/users`, userController.index);
routes.get(`/users/:id`, userController.index);
routes.post(`/users`, userController.create);
routes.put(`/users/:id`, userController.update);
routes.delete(`/users/:id`, userController.destroy);

/**
 * Routes for products control
 */
routes.get(`/products`, productsController.index);
routes.get(`/products/:id`, productsController.index);
routes.post(`/products`, productsController.create);
routes.put(`/products/:id`, productsController.update);
routes.delete(`/products/:id`, productsController.destroy);

/**
 * Routes for companry control
 */
routes.get(`/company`, companyController.index);
routes.get(`/company/:id`, companyController.index);
routes.post(`/company`, companyController.create);
routes.put(`/company/:id`, companyController.update);
routes.delete(`/company/:id`, companyController.destroy);

module.exports = routes;
