import { Request, Response } from "express";
import bankModel from "../models/bankModel";
import getSearchParams from "../utils/getSearchParams";

async function index(req: Request, res: Response) {
  try {
    const _id = req.params.id;
    const { limit, skip } = getSearchParams();

    let found: any[];

    if (_id) {
      found = [await bankModel.findById(_id)];
    } else {
      found = await bankModel
        .find({ isActive: true })
        .sort({ name: 1 })
        .limit(limit)
        .skip(skip);
    }

    return res.json({ count: found.length, docs: found, limit, skip });
  } catch (err) {
    return res.status(500).json({ ok: false, error: err.message });
  }
}

async function create(req: Request, res: Response) {
  try {
    const newAccount = {
      name: req.body.name,
      balance: req.body.balance,
    };

    if (!newAccount.name) throw new Error("Missing name");

    const saved = await bankModel.create(newAccount);

    return res.json({
      count: [saved].length,
      docs: [saved],
      limit: 1,
      skip: 0,
    });
  } catch (err) {
    return res.status(500).json({ ok: false, error: err.message });
  }
}

async function update(req: Request, res: Response) {
  try {
    const _id = req.params.id;
    const newAccount = {
      name: req.body.name,
      balance: req.body.balance,
    };

    const saved = await bankModel.findOneAndUpdate(
      { _id, isActive: true },
      newAccount,
      { new: true }
    );

    return res.json({
      count: [saved].length,
      docs: [saved],
      limit: 1,
      skip: 0,
    });
  } catch (err) {
    return res.status(500).json({ ok: false, error: err.message });
  }
}

async function destroy(req: Request, res: Response) {
  try {
    const _id = req.params.id;

    const saved = await bankModel.findOneAndUpdate(
      { _id },
      { isActive: false },
      { new: true }
    );

    return res.json({
      count: [saved].length,
      docs: [saved],
      limit: 1,
      skip: 0,
    });
  } catch (err) {
    return res.status(500).json({ ok: false, error: err.message });
  }
}

export default { index, create, update, destroy };
