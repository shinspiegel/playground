function userValidate(req) {
  if (!req.body.name) throw new Error('Missing name');

  const product = {
    name: req.body.name,
  };

  if (req.body.isActive !== undefined || req.body.isActive !== null) {
    product.isActive = req.body.isActive;
  }

  return product;
}

module.exports = userValidate;
