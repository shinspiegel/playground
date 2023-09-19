import React from 'react';
import './index.css';
import { useParams, useHistory } from 'react-router-dom';
import useAction from '../../context/useActions';
import ContactForm from '../../layout/ContactForm';

const EditContact = () => {
  const { id } = useParams();
  const { push } = useHistory();

  const { state, editContact } = useAction();
  const { contactList } = state;
  const contact = { ...contactList.find((contact) => contact._id === id) };

  if (!contact) {
    push('/lista-de-contatos');
    return <div />;
  }

  const handleSubmit = (form) => {
    editContact(form);
    push('/lista-de-contatos');
  };

  return (
    <section className='editContact'>
      <h2>Edite as informações do contato abaixo:</h2>
      <ContactForm submitForm={handleSubmit} initalContactForm={contact} />
    </section>
  );
};

export default EditContact;
