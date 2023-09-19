import { getCookie } from './index';

/**
 * This function will return if the user is logged.
 * @returns {Boolean}
 */
const isLogged = () => {
  const userData = getCookie('user');

  if (userData && userData._id && userData.token) {
    return userData;
  }

  return false;
};

export default isLogged;
