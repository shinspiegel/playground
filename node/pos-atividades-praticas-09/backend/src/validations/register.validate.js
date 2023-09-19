function userValidate(req) {
  if (!req.body.name) throw new Error('Missing name');
  if (!req.body.email) throw new Error('Missing email');
  if (!req.body.password) throw new Error('Missing password');

  const contact = {
    name: req.body.name,
    email: req.body.email,
    password: req.body.password,
  };

  if (req.body.isActive !== undefined || req.body.isActive !== null) {
    contact.isActive = req.body.isActive;
  }

  return contact;
}

module.exports = userValidate;
