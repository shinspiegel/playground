const getBody = (body) => {
  const result = {
    student: body.student,
    subject: body.subject,
    type: body.type,
    value: body.value,
  };

  if (typeof result.value !== 'number') {
    result.value = Number(result.value);
  }

  if (
    !result.student ||
    !result.subject ||
    !result.type ||
    !result.value ||
    result.student === '' ||
    result.subject === '' ||
    result.type === '' ||
    Number.isNaN(result.value)
  ) {
    throw new Error('body failed');
  }

  return result;
};

module.exports = getBody;
