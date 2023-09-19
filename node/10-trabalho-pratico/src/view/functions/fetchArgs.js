/**
 * This is a helper function that generates a argument for fetch.
 * @param {Object} config This is the config object
 * @param {Object=} config.type This is the type of the request. Default if GET
 * @param {Object=} config.body This is the body of the request. It will be passed a stringified version of it.
 * @param {Object=} config.auth This request need authentication. Default is false.
 * @returns {Object}
 */
const fetchArgs = ({ type = 'GET', body, auth = false } = {}) => {
  const args = {
    method: type,
    mode: 'cors',
    headers: {
      'Content-Type': 'application/json',
    },
    redirect: 'follow',
  };

  if (body) {
    args.body = JSON.stringify(body);
  }

  return args;
};

export default fetchArgs;
