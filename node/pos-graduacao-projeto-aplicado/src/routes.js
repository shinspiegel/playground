const { Router } = require('express');

const userController = require('./controller/userController');
const loginController = require('./controller/loginController');
const recoverController = require('./controller/recoverController');
const productsController = require('./controller/productsController');
const groceryListController = require('./controller/groceryListController');
const getFromLastWeek = require('./controller/getFromLastWeek');
const themeController = require('./controller/themeController');

const routes = Router();

routes.post('/users', userController.store);
routes.put('/users/:id', userController.update);

routes.post('/login', loginController.store);

routes.get('/recover', recoverController.index);
routes.post('/recover', recoverController.store);

routes.get('/products', productsController.index);
routes.get('/products/:id', productsController.index);
routes.post('/products', productsController.store);
routes.put('/products/:id', productsController.update);
routes.delete('/products/:id', productsController.destroy);

routes.get('/grocery-lists/', groceryListController.index);
routes.get('/grocery-lists/:year', groceryListController.index);
routes.get('/grocery-lists/:year/:week', groceryListController.index);
routes.post('/grocery-lists/:year/:week', groceryListController.store);
routes.put('/grocery-lists/:year/:week', groceryListController.update);
routes.delete('/grocery-lists/:year/:week', groceryListController.destroy);

routes.get('/get-from-last/:year/:week', getFromLastWeek.index);
routes.post('/get-from-last/:year/:week', getFromLastWeek.store);

routes.put('/theme/:userId', themeController.update);

module.exports = routes;
