const { Router } = require('express');

const studentController = require('./controller/studentController');

const routes = Router();

routes.get('/', studentController.index);
routes.get('/:id', studentController.index);
routes.post('/', studentController.store);
routes.put('/:id', studentController.update);
routes.delete('/:id', studentController.destroy);

module.exports = routes;
