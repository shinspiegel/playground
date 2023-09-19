import { Request } from 'express';

interface IBook {
  title: string;
  author: string;
  publisher: string;
  tags: string[];
  isActive?: boolean;
}

function validateBookRequest(req: Request): IBook {
  let book = {} as IBook;

  if (!req.body.title) throw new Error('Missing title');
  if (!req.body.author) throw new Error('Missing author');
  if (!req.body.publisher) throw new Error('Missing publisher');
  if (!req.body.tags || !Array.isArray(req.body.tags) || req.body.tags.length <= 0) throw new Error('Missing tags');

  book = {
    title: req.body.title,
    author: req.body.author,
    publisher: req.body.publisher,
    tags: req.body.tags,
  };

  if (req.body.isActive !== undefined || req.body.isActive !== null) book.isActive = req.body.isActive;

  return book;
}

export default validateBookRequest;
