import React from 'react';
import './index.css';
import { useHistory } from 'react-router-dom';
import ContactForm from '../../layout/ContactForm';
import useAction from '../../context/useActions';

const AddContact = () => {
  const { addContact } = useAction();
  const { push } = useHistory();

  const handleSubmit = (form) => {
    addContact(form);
    push('/lista-de-contatos');
  };

  return (
    <section className='addContact'>
      <h1>Cadastrar contatos</h1>
      <p>Só preencher o formulário abaixo</p>
      <ContactForm submitForm={handleSubmit} />
    </section>
  );
};

export default AddContact;
