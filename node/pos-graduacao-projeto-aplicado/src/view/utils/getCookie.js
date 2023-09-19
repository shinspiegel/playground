import jsCookie from 'js-cookie';

/**
 * This function will return the value of a given cookie name, if no cookie is found will return null
 * @param {String} cookie This is the cookie name to recover
 * @returns {Object}
 */
const getCookie = (cookie) => {
  const data = jsCookie.get(cookie);
  if (!data) return null;

  return JSON.parse(data);
};

export default getCookie;
