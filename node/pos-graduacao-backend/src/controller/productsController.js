const handleError = require('../utils/handleError');
const decryptToken = require('../utils/decryptToken');
const Product = require('../models/products');
const { CodeError, errorList } = require('../utils/CodeError');
const validadeArguments = require('../utils/validadeArguments');

const index = async (req, res) => {
  try {
    decryptToken(await req.headers.authorization);
    const _id = req.params.id;
    const queryString = req.query.search;
    const limit = Number(req.query.limit);
    const skip = Number(req.query.skip);

    if (_id) {
      const productFound = await Product.findOne({ _id }).catch((err) => {
        throw new CodeError({ message: err });
      });

      return res.json(productFound);
    }

    if (queryString) {
      const queryList = queryString.split(' ');
      const objectList = queryList.map((queryItem) => ({
        product: { $regex: queryItem, $options: 'i' },
        isActive: true,
      }));
      const query = { $or: objectList };

      const productList = await Product.find(query)
        .sort({ product: 1 })
        .limit(limit)
        .skip(skip)
        .catch((err) => {
          throw new CodeError({ message: err });
        });

      return res.json(productList);
    }

    const productList = await Product.find({ isActive: true })
      .sort({ category: 1 })
      .limit(limit)
      .skip(skip)
      .catch((err) => {
        throw new CodeError({ message: err });
      });
    return res.json(productList);
  } catch (err) {
    return handleError(err, res);
  }
};

const store = async (req, res) => {
  try {
    const { product, category, subCaterogy, price } = req.body;
    decryptToken(await req.headers.authorization);

    validadeArguments([product, category, price], new CodeError(errorList.invalidArguments));

    const newProduct = await Product.create({
      product,
      category,
      subCaterogy,
      price,
    }).catch((err) => {
      throw new CodeError({ message: err });
    });

    return res.json(newProduct);
  } catch (err) {
    return handleError(err, res);
  }
};

const update = async (req, res) => {
  try {
    decryptToken(await req.headers.authorization);

    const _id = req.params.id;
    const { body } = req.body;

    if (!_id) throw new CodeError(errorList.invalidId);
    if (!body) throw new CodeError(errorList.invalidBody);

    const updatedProduct = await Product.findOneAndUpdate(
      { _id },
      { $set: { ...body } },
      { returnOriginal: false, new: true },
    ).catch((err) => {
      throw new CodeError({ message: err });
    });

    return res.json(updatedProduct);
  } catch (err) {
    return handleError(err, res);
  }
};

const destroy = async (req, res) => {
  try {
    decryptToken(await req.headers.authorization);

    const _id = req.params.id;

    const product = await Product.findOne({ _id }).catch((err) => {
      throw new CodeError({ message: err });
    });

    product.isActive = !product.isActive;

    await product.save().catch((err) => {
      throw new CodeError({ message: err });
    });

    return res.json(product);
  } catch (err) {
    return handleError(err, res);
  }
};

module.exports = { index, store, update, destroy };
