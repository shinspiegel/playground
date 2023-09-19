import { Request, Response } from 'express';
import contactModel, { IContactSchema } from '../models/contactModel';
import getSearchParams from '../utils/getSearchParams';
import validateContactRequest from '../utils/validateContactRequest';

async function index(req: Request, res: Response) {
  try {
    const _id = req.params.id;
    const { limit, skip } = getSearchParams(req);

    let found: IContactSchema[];

    if (_id) {
      found = [await contactModel.findById(_id)];
    } else {
      found = await contactModel.find({ isActive: true }).sort({ name: 1 }).limit(limit).skip(skip);
    }

    const resBody = { count: found.length, docs: found, limit, skip };

    return res.json(resBody);
  } catch (err) {
    return res.status(500).json({ ok: false, error: err.message });
  }
}

async function create(req: Request, res: Response) {
  try {
    const newContact = validateContactRequest(req);

    const saved = await contactModel.create(newContact);

    const resBody = { count: [saved].length, docs: [saved], limit: 1, skip: 0 };

    return res.json(resBody);
  } catch (err) {
    return res.status(500).json({ ok: false, error: err.message });
  }
}

async function update(req: Request, res: Response) {
  try {
    const _id = req.params.id;
    const newContact = validateContactRequest(req);

    const saved = await contactModel.findOneAndUpdate({ _id }, { $set: newContact }, { new: true });

    const resBody = { count: [saved].length, docs: [saved], limit: 1, skip: 0 };

    return res.json(resBody);
  } catch (err) {
    return res.status(500).json({ ok: false, error: err.message });
  }
}

async function destroy(req: Request, res: Response) {
  try {
    const _id = req.params.id;

    const saved = await contactModel.findOneAndUpdate({ _id }, { $set: { isActive: false } }, { new: true });

    const resBody = { count: [saved].length, docs: [saved], limit: 1, skip: 0 };

    return res.json(resBody);
  } catch (err) {
    return res.status(500).json({ ok: false, error: err.message });
  }
}

export default { index, create, update, destroy };
