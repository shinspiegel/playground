const moongoose = require('mongoose');

const groceryListScheme = new moongoose.Schema({
  listOwner: { type: moongoose.Schema.Types.ObjectId, ref: 'users', required: true },
  year: { type: Number, require: true },
  week: { type: Number, require: true },
  productsList: [
    {
      productName: { type: String },
      isBought: { type: Boolean, default: false },
      productReference: { type: moongoose.Schema.Types.ObjectId, ref: 'products' },
    },
  ],
});

module.exports = moongoose.model('groceryList', groceryListScheme);
