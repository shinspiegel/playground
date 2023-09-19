import mongoose from 'mongoose';

export interface IBookSchema extends mongoose.Document {
  title: string;
  author: string;
  publisher: string;
  tags: string[];
  createAt: Date;
  isActive: boolean;
}

export const BookSchema = new mongoose.Schema<IBookSchema>({
  title: { type: String, required: true },
  author: { type: String, required: true },
  publisher: { type: String, required: true },
  tags: [{ type: String, required: true }],
  createAt: { type: Date, required: true, default: new Date() },
  isActive: { type: Boolean, required: true, default: true },
});

export default mongoose.model<IBookSchema>('books', BookSchema);
