import { Request, Response } from 'express';
import bookModel, { IBookSchema } from '../models/bookModel';
import getSearchParams from '../utils/getSearchParams';
import validateBookRequest from '../utils/validateBookRequest';

async function index(req: Request, res: Response) {
  try {
    const _id = req.params.id;
    const { limit, skip } = getSearchParams(req);

    let found: IBookSchema[];

    if (_id) {
      found = [await bookModel.findById(_id)];
    } else {
      found = await bookModel.find({ isActive: true }).sort({ name: 1 }).limit(limit).skip(skip);
    }

    const resBody = { count: found.length, docs: found, limit, skip };

    return res.json(resBody);
  } catch (err) {
    return res.status(500).json({ ok: false, error: err.message });
  }
}

async function create(req: Request, res: Response) {
  try {
    const newBook = validateBookRequest(req);

    const saved = await bookModel.create(newBook);

    const resBody = { count: [saved].length, docs: [saved], limit: 1, skip: 0 };

    return res.json(resBody);
  } catch (err) {
    return res.status(500).json({ ok: false, error: err.message });
  }
}

async function update(req: Request, res: Response) {
  try {
    const _id = req.params.id;
    const newBook = validateBookRequest(req);

    console.log(newBook);

    const saved = await bookModel.findOneAndUpdate({ _id }, { $set: newBook }, { new: true });

    const resBody = { count: [saved].length, docs: [saved], limit: 1, skip: 0 };

    return res.json(resBody);
  } catch (err) {
    return res.status(500).json({ ok: false, error: err.message });
  }
}

async function destroy(req: Request, res: Response) {
  try {
    const _id = req.params.id;

    const saved = await bookModel.findOneAndUpdate({ _id }, { $set: { isActive: false } }, { new: true });

    const resBody = { count: [saved].length, docs: [saved], limit: 1, skip: 0 };

    return res.json(resBody);
  } catch (err) {
    return res.status(500).json({ ok: false, error: err.message });
  }
}

export default { index, create, update, destroy };
