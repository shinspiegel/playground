const getSearchQuery = ({ student, subject, type, id }) => {
  const result = { isActive: true };

  if (id) {
    result._id = id;
    return result;
  }

  if (student) result.student = student;
  if (subject) result.subject = subject;
  if (type) result.type = type;

  return result;
};

module.exports = getSearchQuery;
