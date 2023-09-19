import React, { useState } from 'react';
import swal from 'sweetalert';
import './index.css';
import BasicInput from '../../components/BasicInput';
import BasicButton from '../../components/BasicButton';

const ContactForm = ({
  submitForm,
  initalContactForm = { name: '', email: '', phone: '', address: '' },
}) => {
  const [form, setForm] = useState({ ...initalContactForm });

  const handleSubmit = async (e) => {
    e.preventDefault();
    if (!form || !form.name || !form.email || !form.phone || !form.address)
      return swal('Opps', 'Preencha todos os campos para cadastrar um contato.', 'error');

    if (submitForm) submitForm(form);
    setForm({ name: '', email: '', phone: '', address: '' });
  };

  return (
    <form onSubmit={handleSubmit} className='contactForm'>
      <BasicInput
        initialValue={form.name}
        onChange={(value) => setForm({ ...form, name: value })}
        label='Nome'
        placeholder='Digite o nome do contato.'
      />
      <BasicInput
        initialValue={form.email}
        onChange={(value) => setForm({ ...form, email: value })}
        label='Email'
        placeholder='Digite o email do contato.'
      />
      <BasicInput
        initialValue={form.phone}
        onChange={(value) => setForm({ ...form, phone: value })}
        label='Telefone'
        placeholder='Telefone do contato.'
      />
      <BasicInput
        initialValue={form.address}
        onChange={(value) => setForm({ ...form, address: value })}
        label='Endereço'
        placeholder='Digite o endereço do contato.'
      />
      <BasicButton label='Enviar' />
    </form>
  );
};

export default ContactForm;
