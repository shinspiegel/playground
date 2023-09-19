import jsCookie from 'js-cookie';

/**
 * This function will remove a cookie by it's name.
 * @param {String} cookie This is the name of the cookie.
 */
const setCookie = (cookie) => {
  jsCookie.remove(cookie);
};

export default setCookie;
