import React, { useState } from 'react';
import './index.css';

import useActions from '../../context/useActions';
import packageJson from '../../../../package.json';

import BaseInput from '../../components/BaseInput';
import BaseButton from '../../components/BaseButton';
import Logo from '../../components/Logo';
import VersionDisplay from '../../components/VersionDisplay';

const Login = () => {
  const { state, login } = useActions();
  const { error } = state;

  const [form, setForm] = useState({ email: '', password: '' });

  const onSubmitHandler = async (e) => {
    e.preventDefault();
    login(form);
  };

  return (
    <>
      <main className="loginPage">
        <div className="loginPage-logoArea">
          <Logo white />
          <h1>MeuMercado</h1>
        </div>
        <form className="loginPage-form" onSubmit={onSubmitHandler}>
          <BaseInput
            label="Email"
            placeholder="Digite seu email"
            value={form.email}
            type="email"
            onChange={(email) => setForm({ ...form, email })}
          />
          <BaseInput
            label="Senha"
            placeholder="Digite a senha"
            value={form.password}
            onChange={(password) => setForm({ ...form, password })}
            type="password"
          />
          <BaseButton label="Entrar" />
        </form>
        <a className="loginPage-recover" href="/recover">
          Esqueci minha senha
        </a>
      </main>

      <VersionDisplay version={packageJson.version} />
    </>
  );
};

export default Login;
