const companyModel = require('../models/company.model');
const getSearchParams = require('../utils/getSearchParams');
const companyValidate = require('../validations/company.validate');
const userValidate = require('../validations/user.validate');
const getResponseBody = require('../utils/getResponseBody');
const { validateToken } = require('../utils/token');

async function index(req, res) {
  try {
    validateToken(req.headers.authorization);

    const _id = req.params.id;
    const { limit, skip } = getSearchParams(req);

    let found;

    if (_id) {
      found = [await companyModel.findById(_id)];
    } else {
      found = await companyModel.find({ isActive: true }).sort({ name: 1 }).limit(limit).skip(skip);
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

    const body = companyValidate(req);

    const saved = await companyModel.create(body);

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
    const body = companyValidate(req);

    const saved = await companyModel.findOneAndUpdate({ _id }, { $set: body }, { new: true });

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

    const saved = await companyModel.findOneAndUpdate(
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
