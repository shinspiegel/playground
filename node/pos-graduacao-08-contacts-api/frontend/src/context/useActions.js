import { useContext } from 'react';
import AppContext from './context';
import { reducerCases as redux } from './reducer';
import fetchArgs from '../utils/fetchArgs';

/**
 * This action will return the state and the actions to change de state.
 */
const useActions = () => {
  const { state, dispatch } = useContext(AppContext);

  const fetchContacts = async () => {
    dispatch({ type: redux.setFetching, payload: true });

    const args = fetchArgs();
    const data = await fetch('http://localhost:9000/api/contacts', args)
      .then((res) => res.json())
      .catch(console.log);

    dispatch({ type: redux.setFetching, payload: false });
    dispatch({ type: redux.setContacts, payload: data.docs });
  };

  const addContact = async (contactForm) => {
    const args = fetchArgs({ type: 'POST', body: contactForm });
    await fetch(`http://localhost:9000/api/contacts`, args)
      .then((res) => res.json())
      .catch(console.log);

    dispatch({ type: redux.setContacts, payload: [...state.contactList, contactForm] });
  };

  const editContact = async (contactForm) => {
    const args = fetchArgs({ type: 'PUT', body: contactForm });
    await fetch(`http://localhost:9000/api/contacts/${contactForm._id}`, args)
      .then((res) => res.json())
      .catch(console.log);
  };

  const removeContact = async (contactID) => {
    const args = fetchArgs({ type: 'DELETE' });
    fetch(`http://localhost:9000/api/contacts/${contactID}`, args)
      .then((res) => res.json())
      .catch(console.log);

    const newContactList = [...state.contactList].filter((contact) => contact._id !== contactID);

    dispatch({ type: redux.setContacts, payload: newContactList });
  };

  return {
    state,
    fetchContacts,
    addContact,
    editContact,
    removeContact,
  };
};

export default useActions;
