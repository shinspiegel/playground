/**
 * @returns {String} return
 */
const getCurrentURL = () => {
  const currentURL = req.protocol + '://' + req.get('host');
  const fullPath = req.protocol + '://' + req.get('host') + req.originalUrl;

  return currentURL;
};

module.exports = getCurrentURL;
