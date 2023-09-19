const { CodeError, errorList } = require('../utils/CodeError');

const getUserID = (userObject) => {
  if (!userObject) throw new CodeError(errorList.invalidToken);
  if (!userObject._id) throw new CodeError(errorList.invalidTokenId);

  return userObject._id;
};

module.exports = getUserID;
