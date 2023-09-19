/**
 * This funtion will create a response for any given error.
 * @param {CodeError} error The extended javascript error.
 * @param {Object} response This is the express response object.
 */
const handleError = (error, response) => {
  console.warn(`  ----------------------------------------------
  ERROR: ${error.id} 
  Code: ${error.code}
  Message: ${error.message}
  Stack: ${error.stack}
  `);

  return response.status(error.code || 500).json({ error: error.id, message: error.message });
};

module.exports = handleError;
