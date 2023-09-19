const User = require('../models/user');
const hash = require('../utils/hashString');
const addToken = require('../utils/addToken');
const handleError = require('../utils/handleError');
const { CodeError, errorList } = require('../utils/CodeError');
const validadeArguments = require('../utils/validadeArguments');

const index = async (req, res) => {
  return handleError(new CodeError(errorList.notImplemented), res);
};

const store = async (req, res) => {
  try {
    const { email, password } = req.body;

    validadeArguments([email, password], new CodeError(errorList.invalidArguments));

    const findedUser = await User.findOne({ email }).catch((err) => {
      throw new CodeError({ message: err });
    });

    if (!findedUser) throw new CodeError(errorList.emailNotFound);

    hash.compareStrings(password, findedUser.password);
    const signedUser = addToken(findedUser);

    return res.json(signedUser);
  } catch (err) {
    return handleError(err, res);
  }
};

const update = async (req, res) => {
  return handleError(new CodeError(errorList.notImplemented), res);
};

const destroy = async (req, res) => {
  return handleError(new CodeError(errorList.notImplemented), res);
};

module.exports = { index, store, update, destroy };
