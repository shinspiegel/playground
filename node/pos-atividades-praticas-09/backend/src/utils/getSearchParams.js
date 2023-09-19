function getSearchParams(req) {
  const searchParams = { limit: 100, skip: 0 };

  if (req.params.limit && Number(req.params.limit) > 0) {
    searchParams.limit = Number(req.params.limit);
  }

  if (req.params.skip && Number(req.params.limit) > 0) {
    searchParams.skip = Number(req.params.skip);
  }

  return searchParams;
}

module.exports = getSearchParams;
