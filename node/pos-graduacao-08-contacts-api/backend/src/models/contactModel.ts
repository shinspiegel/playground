import mongoose from 'mongoose';

export interface IContactSchema extends mongoose.Document {
  name: string;
  email: string;
  phone: string;
  address: string;
  isActive?: boolean;
}

export const ContactSchema = new mongoose.Schema<IContactSchema>({
  name: { type: String, required: true },
  email: { type: String, required: true },
  phone: { type: String, required: true },
  address: { type: String, required: true },
  isActive: { type: Boolean, default: true },
});

export default mongoose.model<IContactSchema>('contacts', ContactSchema);
