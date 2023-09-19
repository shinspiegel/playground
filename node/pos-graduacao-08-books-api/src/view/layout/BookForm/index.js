import React, { useState } from 'react';
import swal from 'sweetalert';
import './index.css';
import BasicInput from '../../components/BasicInput';
import BasicButton from '../../components/BasicButton';

const BookForm = ({ submitForm, initalBookForm = { title: '', author: '', publisher: '', tags: '' } }) => {
  const [form, setForm] = useState({ ...initalBookForm });

  const handleSubmit = async (e) => {
    console.log(form);

    e.preventDefault();
    if (!form || !form.author || !form.title || !form.publisher || !form.tags)
      return swal('Opps', 'Preencha todos os campos para cadastrar o livro.', 'error');

    if (submitForm) submitForm(form);
    setForm({ title: '', author: '', publisher: '', tags: '' });
  };

  return (
    <form onSubmit={handleSubmit} className="bookForm">
      <BasicInput
        initialValue={form.title}
        onChange={(value) => setForm({ ...form, title: value })}
        label="Título"
        placeholder="Título da obra que queres adicionar."
      />
      <BasicInput
        initialValue={form.author}
        onChange={(value) => setForm({ ...form, author: value })}
        label="Autor"
        placeholder="Autor dessa obra."
      />
      <BasicInput
        initialValue={form.publisher}
        onChange={(value) => setForm({ ...form, publisher: value })}
        label="Editora"
        placeholder="Editora desse livro."
      />
      <BasicInput
        initialValue={form.tags}
        onChange={(value) => setForm({ ...form, tags: value })}
        label="Área"
        placeholder="Quais são as palavras chave deste livro."
      />
      <BasicButton label="Enviar" />
    </form>
  );
};

export default BookForm;
