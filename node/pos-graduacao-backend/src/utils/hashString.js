const bcrypt = require('bcryptjs');
const salt = process.env.SALT;
const { CodeError, errorList } = require('./CodeError');

/**
 * Converte uma string em uma hash string.
 * @param {String} stringToHash string para fazer o hash
 * @returns {String}
 */
const hashString = (stringToHash) => {
  const hashedString = bcrypt.hashSync(stringToHash, salt);
  return hashedString;
};

/**
 * Garante que uma string foi hasheada de maneira correta, ou retorna um false.
 * @param {String} stringToCheck String que irá ser verificada
 */
const checkString = (stringToCheck) => {
  const isOk = bcrypt.compareSync(stringToHash, salt);
  return isOk;
};

/**
 * Confere para garantir que uma string é igual ao a uma string hasheada
 * @param {String} requestString String sem hash
 * @param {String} storageHash String com hash
 */
const compareStrings = (requestString, storageHash) => {
  const hashedString = bcrypt.hashSync(requestString, salt);

  if (hashedString !== storageHash) throw new CodeError(errorList.invalidPassword);

  return true;
};

module.exports = {
  hashString,
  checkString,
  compareStrings,
};
