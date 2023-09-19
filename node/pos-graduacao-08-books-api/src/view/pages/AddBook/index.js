import React from 'react';
import './index.css';
import { useHistory } from 'react-router-dom';
import BookForm from '../../layout/BookForm';
import useAction from '../../context/useActions';

const AddBook = () => {
  const { addBook } = useAction();
  const { push } = useHistory();

  const handleSubmit = (form) => {
    addBook(form);
    push('/lista-de-livros');
  };

  return (
    <section className="addBook">
      <h1>Cadastrar Livro</h1>
      <p>Só preencher o formulário abaixo</p>
      <BookForm submitForm={handleSubmit} />
    </section>
  );
};

export default AddBook;
