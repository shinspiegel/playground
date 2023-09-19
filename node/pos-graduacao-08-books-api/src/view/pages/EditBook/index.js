import React from 'react';
import './index.css';
import { useParams, useHistory } from 'react-router-dom';
import useAction from '../../context/useActions';
import BookForm from '../../layout/BookForm';

const EditBook = () => {
  const { id } = useParams();
  const { push } = useHistory();

  const { state, editBook } = useAction();
  const { bookList } = state;
  const book = { ...bookList.find((book) => book._id === id) };

  if (!book) {
    push('/lista-de-livros');
    return <div />;
  }

  book.tags = book.tags.join(', ');

  const handleSubmit = (form) => {
    editBook(form);
    push('/lista-de-livros');
  };

  return (
    <section className="editBook">
      <h2>Edite as informações do livro abaixo:</h2>
      <BookForm submitForm={handleSubmit} initalBookForm={book} />
    </section>
  );
};

export default EditBook;
