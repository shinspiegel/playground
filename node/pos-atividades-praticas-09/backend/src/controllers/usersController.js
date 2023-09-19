const userModel = require('../models/users.model');
const getSearchParams = require('../utils/getSearchParams');
const registerValidate = require('../validations/register.validate');
const userValidate = require('../validations/user.validate');
const getResponseBody = require('../utils/getResponseBody');
const { generateHash } = require('../utils/hash');
const { validateToken } = require('../utils/token');

async function index(req, res) {
  try {
    validateToken(req.headers.authorization);

    const _id = req.params.id;
    const { limit, skip } = getSearchParams(req);

    let found;

    if (_id) {
      found = [await userModel.findById(_id)];
    } else {
      found = await userModel.find({ isActive: true }).sort({ name: 1 }).limit(limit).skip(skip);
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

    const body = registerValidate(req);

    body.password = generateHash(body.password);

    const saved = await userModel.create(body);
    delete saved.password;

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
    const body = userValidate(req);

    const saved = await userModel.findOneAndUpdate({ _id }, { $set: body }, { new: true });

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

    const saved = await userModel.findOneAndUpdate(
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
