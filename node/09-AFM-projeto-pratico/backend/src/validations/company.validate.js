function userValidate(req) {
  if (!req.body.companyName) throw new Error('Missing company name');
  if (!req.body.corporateName) throw new Error('Missing corporate name');
  if (!req.body.corporateCode) throw new Error('Missing corporate code');
  if (!req.body.address) throw new Error('Missing address');
  if (!req.body.address.city) throw new Error('Missing adress city');

  const contact = {
    companyName: req.body.companyName,
    corporateName: req.body.corporateName,
    corporateCode: req.body.corporateCode,
    address: {
      city: req.body.address.city,
    },
  };

  if (req.body.isActive !== undefined || req.body.isActive !== null) {
    contact.isActive = req.body.isActive;
  }

  if (req.body.address.neighborhood) {
    contact.address.neighborhood = req.body.address.neighborhood;
  }

  if (req.body.address.street) {
    contact.address.street = req.body.address.street;
  }

  if (req.body.address.number) {
    contact.address.number = req.body.address.number;
  }

  return contact;
}

module.exports = userValidate;
