import React, { useEffect } from 'react';
import swal from 'sweetalert';
import { useHistory } from 'react-router-dom';
import './index.css';
import useAction from '../../context/useActions';
import BookItem from '../../components/BookItem';

const BookList = () => {
  const { push } = useHistory();
  const { state, fetchBooks, removeBook } = useAction();
  const { bookList, isFetching } = state;

  useEffect(() => {
    fetchBooks();
  }, []);

  const handleRemove = (bookId) => {
    swal({
      title: 'Tem certeza?',
      text: 'Uma vez deletado, não tem como recuperar este livro',
      icon: 'warning',
      buttons: true,
      dangerMode: true,
    }).then((del) => (del ? removeBook(bookId) : null));
  };

  if (isFetching) {
    return (
      <section className="bookList">
        <h2>Carregando!</h2>
        <p>
          Enquanto isso, você sabia que pode adicionar livros também? Só clicar no botão de adicionar no menu superior.
        </p>
      </section>
    );
  }

  if (bookList.length <= 0) {
    return (
      <section className="bookList">
        <h2>Nenhum livro aqui 😢</h2>
        <p>Você poderia adicionar alguns livros para me deixar feliz?</p>
      </section>
    );
  }

  return (
    <section className="bookList">
      <ul>
        {bookList.map((book, index) => (
          <BookItem
            key={book._id + index}
            book={book}
            removeBook={() => handleRemove(book._id)}
            editBook={() => push(`/editar-livro/${book._id}`)}
          />
        ))}
      </ul>
    </section>
  );
};

export default BookList;
