function userValidate(req) {
  if (!req.body.email) throw new Error('Missing email');
  if (!req.body.password) throw new Error('Missing phone');

  const contact = {
    email: req.body.email,
    password: req.body.password,
  };

  return contact;
}

module.exports = userValidate;
