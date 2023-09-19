import { Request, Response } from "express";
import bankModel from "../models/bankModel";
import getSearchParams from "../utils/getSearchParams";

async function deposit(req: Request, res: Response) {
  try {
    const _id = req.params.id;
    const depositValue = Number(req.body.deposit);
    const { limit, skip } = getSearchParams();

    if (Number.isNaN(depositValue) || depositValue <= 0)
      throw new Error("Invalid deposit value");

    const updatedAccount = await bankModel.findOneAndUpdate(
      { _id, isActive: true },
      { $inc: { balance: depositValue } },
      { new: true }
    );

    return res.json({
      count: [updatedAccount].length,
      docs: [updatedAccount],
      limit,
      skip,
    });
  } catch (err) {
    return res.status(500).json({ ok: false, error: err.message });
  }
}

async function withdraw(req: Request, res: Response) {
  try {
    const _id = req.params.id;
    const withdrawValue = Number(req.body.withdraw);
    const { limit, skip } = getSearchParams();

    if (Number.isNaN(withdrawValue) || withdrawValue <= 0)
      throw new Error("Invalid deposit value");

    const updatedAccount = await bankModel.findOne({ _id, isActive: true });
    if (updatedAccount.balance - withdrawValue < 0)
      throw new Error("Saldo insuficiente");

    updatedAccount.balance = updatedAccount.balance - withdrawValue;
    await updatedAccount.save();

    return res.json({
      count: [updatedAccount].length,
      docs: [updatedAccount],
      limit,
      skip,
    });
  } catch (err) {
    return res.status(500).json({ ok: false, error: err.message });
  }
}

export default { deposit, withdraw };
