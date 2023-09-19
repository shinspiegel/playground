import React, { useState } from 'react';
import './index.css';

import useActions from '../../context/useActions';
import packageJson from '../../../../package.json';

import BaseInput from '../../components/BaseInput';
import BaseButton from '../../components/BaseButton';
import Logo from '../../components/Logo';
import VersionDisplay from '../../components/VersionDisplay';

const Register = () => {
  const { register } = useActions();
  const [form, setForm] = useState({ name: '', email: '', password: '' });

  const onSubmitHandler = (event) => {
    event.preventDefault();
    register(form);
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
            label="Nome"
            placeholder="Digite seu nome"
            value={form.name}
            onChange={(name) => setForm({ ...form, name })}
          />
          <BaseInput
            label="Email"
            placeholder="Digite seu email para registro"
            value={form.email}
            onChange={(email) => setForm({ ...form, email })}
          />
          <BaseInput
            label="Senha"
            placeholder="Digite a senha para registro"
            value={form.password}
            type="password"
            onChange={(password) => setForm({ ...form, password })}
          />
          <BaseButton label="Cadastrar" />
        </form>
      </main>

      <VersionDisplay version={packageJson.version} />
    </>
  );
};

export default Register;
