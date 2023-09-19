const { CodeError, errorList } = require('./CodeError');

/**
 * This function will validade any data in the array, any of them is 'undefined' or 'null' will throw a error.
 * @param {Any[]} arrayOfData This is the array of data that will be validated.
 * @param {CodeError=} error This is the error to be throwed. Default is a id:00 error.
 * @returns {Boolean} If no error is found it will return a true.
 */
const validadeArguments = (arrayOfData, error) => {
  for (let i = 0; i < arrayOfData.length; i++) {
    const arrayItem = arrayOfData[i];
    if (arrayItem === null || arrayItem === undefined) {
      if (error) throw error;

      throw new CodeError(errorList.default);
    }
  }

  return true;
};

module.exports = validadeArguments;
