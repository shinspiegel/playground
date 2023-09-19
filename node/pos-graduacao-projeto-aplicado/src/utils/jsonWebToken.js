const jwt = require('jsonwebtoken');
const validDate = Math.floor(Date.now() / 1000) - 30;

/**
 * This function will encrypt any given data on a jwt token.
 * @param {String} userData This could be any data. For this project you could use at least 'name', 'email' and '_id".
 */
const encrypt = (userData) => {
  const signedToken = jwt.sign({ userData, iat: validDate }, process.env.SECRET);
  return signedToken;
};

/**
 * This function will return a decryped version of the given token.
 * @param {String} token A jwt valid token
 */
const decrypt = (token) => {
  const decrypted = jwt.verify(token, process.env.SECRET);
  return decrypted;
};

module.exports = {
  encrypt,
  decrypt,
};
