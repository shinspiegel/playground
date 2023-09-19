const User = require('../models/user');
const hash = require('../utils/hashString');
const removePassword = require('../utils/removePassword');
const isMailValid = require('../utils/isMailValid');
const validateArguments = require('../utils/validadeArguments');
const addToken = require('../utils/addToken');
const handleError = require('../utils/handleError');
const decryptToken = require('../utils/decryptToken');
const { CodeError, errorList } = require('../utils/CodeError');

const index = async (req, res) => {
  return handleError(new CodeError(errorList.notImplemented), res);
};

const store = async (req, res) => {
  try {
    const { name, email, password } = req.body;

    await isMailValid(email);

    const hashPassword = hash.hashString(password);

    const newUser = await User.create({
      name,
      email,
      password: hashPassword,
    }).catch((err) => {
      throw new CodeError({ message: err });
    });

    const cleanedUser = removePassword(newUser);
    const signedUser = addToken(cleanedUser);

    return res.json(signedUser);
  } catch (err) {
    return handleError(err, res);
  }
};

const update = async (req, res) => {
  try {
    const { name, email, password } = req.body;

    validateArguments([name, email, password], new CodeError(errorList.invalidArguments));

    const hashPassword = hash.hashString(password);
    const { id: paramId } = req.params;
    const { userData } = decryptToken(await req.headers.authorization);

    if (paramId !== userData._id) throw new CodeError(errorList.missMatchId);

    const updatedUser = await User.findOneAndUpdate(
      { _id: userData._id },
      { name, email, password: hashPassword },
      { new: true },
    ).catch((err) => {
      throw new CodeError({ message: err });
    });

    const cleanedUser = removePassword(updatedUser);
    const signedUser = addToken(cleanedUser);

    return res.json(signedUser);
  } catch (err) {
    return handleError(err, res);
  }
};

const destroy = async (req, res) => {
  return handleError(new CodeError(errorList.notImplemented), res);
};

module.exports = { index, store, update, destroy };
