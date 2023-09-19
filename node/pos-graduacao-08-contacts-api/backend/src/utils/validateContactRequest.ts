import { Request } from 'express';

interface IContact {
  name: string;
  email: string;
  phone: string;
  address: string;
  isActive?: boolean;
}

function validateContactRequest(req: Request): IContact {
  let contact = {} as IContact;

  if (!req.body.name) throw new Error('Missing name');
  if (!req.body.email) throw new Error('Missing email');
  if (!req.body.phone) throw new Error('Missing phone');
  if (!req.body.phone) throw new Error('Missing address');

  contact = {
    name: req.body.name,
    email: req.body.email,
    phone: req.body.phone,
    address: req.body.address,
  };

  if (req.body.isActive !== undefined || req.body.isActive !== null) contact.isActive = req.body.isActive;

  return contact;
}

export default validateContactRequest;
