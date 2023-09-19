/**
 * This function will remove the password information from a usermodel from moongoose.
 * @param {Object} userModel The userModel from mongoose without 'lean()'
 */
const removePassword = (userModel) => {
  delete userModel._doc.password;
  return userModel;
};

module.exports = removePassword;
