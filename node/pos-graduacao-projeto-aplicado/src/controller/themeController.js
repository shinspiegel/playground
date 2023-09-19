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
  return handleError(new CodeError(errorList.notImplemented), res);
};

const update = async (req, res) => {
  const { userData } = decryptToken(await req.headers.authorization);
  const { theme } = req.body;
  const { userId } = req.params;

  validateArguments([theme], new CodeError(errorList.invalidArguments));

  if (userId !== userData._id) throw new CodeError(errorList.missMatchId);

  const updatedUser = await User.findOneAndUpdate(
    { _id: userData._id },
    { userTheme: theme },
    { new: true },
  ).catch((err) => {
    throw new CodeError({ message: err });
  });

  const cleanedUser = removePassword(updatedUser);
  const signedUser = addToken(cleanedUser);

  return res.json(signedUser);
};

const destroy = async (req, res) => {
  return handleError(new CodeError(errorList.notImplemented), res);
};

module.exports = { index, store, update, destroy };
