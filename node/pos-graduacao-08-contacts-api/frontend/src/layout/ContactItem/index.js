import React from 'react';
import './index.css';

const ContactItem = ({ contact, editContact, removeContact }) => {
  return (
    <li className='contactItem'>
      <h2>
        <span>Nome: </span>
        {contact.name}
      </h2>
      <ul>
        <span>Telefone: </span>
        {contact.phone}
      </ul>
      <p>
        <span>Endereço: </span>
        {contact.address}
      </p>
      <small>
        <span>Email: </span>
        {contact.email}
      </small>
      <div>
        <button onClick={editContact}>Editar</button>
        <button onClick={removeContact}>Apagar</button>
      </div>
    </li>
  );
};

export default ContactItem;
