const userModel = require('../models/users.model');
const registerValidate = require('../validations/register.validate');
const loginValidate = require('../validations/login.validate');
const getResponseBody = require('../utils/getResponseBody');
const { generateHash, validateHash } = require('../utils/hash');
const { generateToken } = require('../utils/token');

async function login(req, res) {
  try {
    const { email, password } = loginValidate(req);

    const found = await userModel.findOne({ email }).lean();

    if (!found) {
      throw new Error('User not found.');
    }

    if (!validateHash(found.password, password)) {
      throw new Error('Invalid password');
    }

    const { token } = generateToken(found);

    delete found.password;

    const resBody = getResponseBody({ docs: [{ ...found, token }] });

    return res.json(resBody);
  } catch (err) {
    return res.status(500).json({ ok: false, error: err.message });
  }
}

async function register(req, res) {
  try {
    const newContact = registerValidate(req);

    newContact.password = generateHash(newContact.password);

    const newID = await userModel.create(newContact);

    const found = await userModel.findById(newID._id).lean();

    const { token } = generateToken(newID);

    const resBody = getResponseBody({ docs: [{ ...found, token }] });

    return res.json(resBody);
  } catch (err) {
    return res.status(500).json({ ok: false, error: err.message });
  }
}

module.exports = { login, register };
