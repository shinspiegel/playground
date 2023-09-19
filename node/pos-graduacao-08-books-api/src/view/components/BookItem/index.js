import React from 'react';
import './index.css';

const BookItem = ({ book, editBook, removeBook }) => {
  return (
    <li className="bookItem">
      <h2>
        <span>Título: </span>
        {book.title}
      </h2>
      <ul>
        {book.tags.map((tag, index) => (
          <li key={index}>{tag}</li>
        ))}
      </ul>
      <p>
        <span>Autorx: </span>
        {book.author}
      </p>
      <small>
        <span>Editora: </span>
        {book.publisher}
      </small>
      <div>
        <button onClick={editBook}>Editar</button>
        <button onClick={removeBook}>Apagar</button>
      </div>
    </li>
  );
};

export default BookItem;
