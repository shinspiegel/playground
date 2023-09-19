import jsCookie from 'js-cookie';

/**
 * This function will set a new cookie in the browser with 7 days expiration date.
 * @param {String} cookie This is the name of the cookie.
 * @param {Object} data This is the string to set in the cookie.
 * @returns {Null}
 */
const setCookie = (cookie, data) => {
  jsCookie.set(cookie, JSON.stringify(data), { expires: 7 });
};

export default setCookie;
