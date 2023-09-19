const User = require('../models/user');
const { CodeError, errorList } = require('./CodeError');

/**
 * This function will check on the database for any given email and return the user, otherwise will throw a error.
 * @param {String} email The email to check on the database.
 */
const isMailValid = async (email) => {
  const findedUser = await User.findOne({ email });

  if (findedUser) throw new CodeError(errorList.emailAlreadyInUse);

  return null;
};

module.exports = isMailValid;
