import React, { useEffect } from 'react';
import { useHistory } from 'react-router-dom';
import swal from 'sweetalert';
import './index.css';
import useAction from '../../context/useActions';
import ContactItem from '../../layout/ContactItem';

const ContactList = () => {
  const { push } = useHistory();
  const { state, fetchContacts, removeContact } = useAction();
  const { contactList, isFetching } = state;

  useEffect(() => {
    fetchContacts();
  }, []);

  const handleRemove = (contactID) => {
    swal({
      title: 'Tem certeza?',
      text: 'Uma vez deletado, não tem como recuperar este livro',
      icon: 'warning',
      buttons: true,
      dangerMode: true,
    }).then((del) => (del ? removeContact(contactID) : null));
  };

  if (isFetching) {
    return (
      <section className='contactList'>
        <h2>Carregando</h2>
        <p>Segura aí que os contatinhos já vão chegar!</p>
      </section>
    );
  }

  if (contactList.length <= 0) {
    return (
      <section className='contactList'>
        <h2>Nenhum contatinho 😏</h2>
        <p>Adicionar uns aí!</p>
      </section>
    );
  }

  return (
    <section className='contactList'>
      <ul>
        {contactList.map((contact, index) => (
          <ContactItem
            key={contact._id + index}
            contact={contact}
            removeContact={() => handleRemove(contact._id)}
            editContact={() => push(`/editar-contato/${contact._id}`)}
          />
        ))}
      </ul>
    </section>
  );
};

export default ContactList;
