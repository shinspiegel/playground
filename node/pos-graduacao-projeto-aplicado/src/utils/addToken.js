const jsonWebToken = require('./jsonWebToken');

/**
 * This function adds a token to a user model finded by moongoose.
 * @param {Object} userModel User model from the moongose, without .lean()
 */
const addToken = (userModel) => {
  const { name, email, _id } = userModel._doc;
  userModel._doc.token = jsonWebToken.encrypt({ name, email, _id });
  return userModel;
};

module.exports = addToken;
