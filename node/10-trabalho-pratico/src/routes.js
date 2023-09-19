const { Router } = require('express');
const sheetController = require('./controllers/sheetController');

const routes = Router();

/**
 * Routes control
 */
routes.get(`/sheets`, sheetController.index);
routes.get(`/sheets/:id`, sheetController.index);
routes.post(`/sheets`, sheetController.create);
routes.put(`/sheets/:id`, sheetController.update);
routes.delete(`/sheets/:id`, sheetController.destroy);

module.exports = routes;
