import React, { useState } from 'react';
import './index.css';

import useActions from '../../context/useActions';
import packageJson from '../../../../package.json';

import BaseInput from '../../components/BaseInput';
import BaseButton from '../../components/BaseButton';
import Logo from '../../components/Logo';
import VersionDisplay from '../../components/VersionDisplay';

const Register = () => {
  const { recover } = useActions();
  const [form, setForm] = useState({ email: '' });

  const onSubmitHandler = (event) => {
    event.preventDefault();
    recover(form);
  };

  return (
    <>
      <main className="registerPage">
        <div className="registerPage-logoArea">
          <Logo size={15} white />
          <h1>MeuMercado</h1>
        </div>
        <form className="registerPage-form" onSubmit={onSubmitHandler}>
          <BaseInput
            label="Email"
            placeholder="Digite seu email para recuperar"
            value={form.email}
            onChange={(email) => setForm({ ...form, email })}
          />
          <BaseButton label="Recuperar cadastro" />
        </form>
      </main>

      <VersionDisplay version={packageJson.version} />
    </>
  );
};

export default Register;
