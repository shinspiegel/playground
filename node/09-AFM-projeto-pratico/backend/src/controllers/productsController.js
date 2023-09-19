const productModel = require('../models/product.model');
const getSearchParams = require('../utils/getSearchParams');
const productValidate = require('../validations/product.validate');
const getResponseBody = require('../utils/getResponseBody');
const { validateToken } = require('../utils/token');

async function index(req, res) {
  try {
    validateToken(req.headers.authorization);

    const _id = req.params.id;
    const { limit, skip } = getSearchParams(req);

    let found;

    if (_id) {
      found = [await productModel.findById(_id)];
    } else {
      found = await productModel.find({ isActive: true }).sort({ name: 1 }).limit(limit).skip(skip);
    }

    const resBody = getResponseBody({ docs: found });

    return res.json(resBody);
  } catch (err) {
    return res.status(500).json({ ok: false, error: err.message });
  }
}

async function create(req, res) {
  try {
    validateToken(req.headers.authorization);

    const body = productValidate(req);

    const saved = await productModel.create(body);

    const resBody = getResponseBody({ docs: [saved] });

    return res.json(resBody);
  } catch (err) {
    return res.status(500).json({ ok: false, error: err.message });
  }
}

async function update(req, res) {
  try {
    validateToken(req.headers.authorization);

    const _id = req.params.id;
    const body = productValidate(req);

    const saved = await productModel.findOneAndUpdate({ _id }, { $set: body }, { new: true });

    const resBody = getResponseBody({ docs: [saved] });

    return res.json(resBody);
  } catch (err) {
    return res.status(500).json({ ok: false, error: err.message });
  }
}

async function destroy(req, res) {
  try {
    validateToken(req.headers.authorization);

    const _id = req.params.id;

    const saved = await productModel.findOneAndUpdate(
      { _id },
      { $set: { isActive: false } },
      { new: true },
    );

    const resBody = getResponseBody({ docs: [saved] });

    return res.json(resBody);
  } catch (err) {
    return res.status(500).json({ ok: false, error: err.message });
  }
}

module.exports = { index, create, update, destroy };
