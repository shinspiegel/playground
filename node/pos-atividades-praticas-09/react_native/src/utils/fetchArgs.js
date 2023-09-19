/**
 * This is a helper function that generates a argument for fetch.
 * @param {Object=} config This is the config object
 * @param {String=} config.type This is the type of the request. Default if GET
 * @param {Object=} config.body This is the body of the request. It will be passed a stringified version of it.
 * @param {String=} config.auth This request auth token string.
 */
const fetchArgs = ({ type = "GET", body, auth = false } = {}) => {
  const args = {
    method: type,
    mode: "cors",
    headers: {
      Accept: "application/json",
      "Content-Type": "application/json",
    },
    redirect: "follow",
  };

  if (auth) {
    args.headers["Authorization"] = `Authorization ${auth}`;
  }

  if (body) {
    args.body = JSON.stringify(body);
  }

  return args;
};

export default fetchArgs;
