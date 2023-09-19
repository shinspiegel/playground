const moongoose = require('mongoose');
const categoryList = require('./enumLists/categoryList.json');

const productScheme = new moongoose.Schema({
  product: { type: String, required: true },
  category: { type: String, enum: categoryList, required: false },
  subCaterogy: { type: [String], default: [] },
  price: { type: Number, required: true },
  isActive: { type: Boolean, required: true, default: true },
});

module.exports = moongoose.model('products', productScheme);
