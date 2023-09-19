const getQuery = (query = {}) => {
  const result = {
    limit: 10,
    skip: 0,
  };

  if (query.limit && !Number.isNaN(Number(query.limit))) {
    result.limit = Number(query.limit);
  }

  if (query.skip && !Number.isNaN(Number(query.skip))) {
    result.skip = Number(query.skip);
  }

  if (query.student && query.student !== '') {
    result.student = query.student;
  }

  if (query.subject && query.subject !== '') {
    result.subject = query.subject;
  }

  if (query.type && query.type !== '') {
    result.type = query.type;
  }

  return result;
};

module.exports = getQuery;
