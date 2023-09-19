import { useContext } from 'react';
import AppContext from './context';
import { reducerCases as redux } from './reducer';
import fetchArgs from '../utils/fetchArgs';

/**
 * This action will return the state and the actions to change de state.
 */
const useActions = () => {
  const { state, dispatch } = useContext(AppContext);

  const fetchBooks = async () => {
    dispatch({ type: redux.setFetching, payload: true });

    const args = fetchArgs();
    const data = await fetch('/api/books', args)
      .then((res) => res.json())
      .catch(console.log);

    dispatch({ type: redux.setFetching, payload: false });
    dispatch({ type: redux.setBooks, payload: data.docs });
  };

  const addBook = async (bookForm) => {
    bookForm.tags = bookForm.tags.split(',').map((tag) => tag.trim());

    const args = fetchArgs({ type: 'POST', body: bookForm });
    await fetch(`/api/books/`, args)
      .then((res) => res.json())
      .catch(console.log);

    dispatch({ type: redux.setBooks, payload: [...state.bookList, bookForm] });
  };

  const editBook = async (bookForm) => {
    bookForm.tags = bookForm.tags.split(',').map((tag) => tag.trim());

    const args = fetchArgs({ type: 'PUT', body: bookForm });
    await fetch(`/api/books/${bookForm._id}`, args)
      .then((res) => res.json())
      .catch(console.log);
  };

  const removeBook = async (bookID) => {
    const args = fetchArgs({ type: 'DELETE' });
    fetch(`/api/books/${bookID}`, args)
      .then((res) => res.json())
      .catch(console.log);

    const newBookList = [...state.bookList].filter((book) => book._id !== bookID);

    dispatch({ type: redux.setBooks, payload: newBookList });
  };

  return {
    state,
    fetchBooks,
    addBook,
    editBook,
    removeBook,
  };
};

export default useActions;
