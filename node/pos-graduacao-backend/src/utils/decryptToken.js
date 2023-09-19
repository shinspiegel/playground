const jsonWebToken = require('../utils/jsonWebToken');
const { CodeError, errorList } = require('./CodeError');

/**
 * This funciton receives a Bearer token, splits and decryptes the token
 * @param {String} bearerToken This is the token, with the bearer in it.
 */
const decryptToken = (bearerToken) => {
  if (!bearerToken) throw new CodeError(errorList.missingToken);

  const token = bearerToken.split(' ')[0];

  let decrypted;

  try {
    decrypted = jsonWebToken.decrypt(token);
  } catch (err) {
    throw new CodeError(errorList.invalidToken);
  }

  return decrypted;
};

module.exports = decryptToken;
