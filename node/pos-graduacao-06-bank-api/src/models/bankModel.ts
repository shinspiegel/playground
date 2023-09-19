import mongoose from "mongoose";

export interface IBankSchema extends mongoose.Document {
  name: string;
  balance: number;
  isActive: boolean;
}

export const BankSchema = new mongoose.Schema({
  name: { type: String, required: true },
  balance: { type: Number, default: 0 },
  isActive: { type: Boolean, required: true, default: true },
});

export default mongoose.model<IBankSchema>("accounts", BankSchema);
