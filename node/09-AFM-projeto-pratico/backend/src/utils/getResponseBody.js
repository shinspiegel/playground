function createResponseBody({ docs, skip = 0, limit = 1 }) {
  return {
    count: docs.length,
    docs,
    skip,
    limit,
  };
}

module.exports = createResponseBody;
