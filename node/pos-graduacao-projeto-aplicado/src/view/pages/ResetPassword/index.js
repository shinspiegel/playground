import React, { useState } from 'react';
import './index.css';

import { useParams, useHistory } from 'react-router-dom';
import useActions from '../../context/useActions';
import packageJson from '../../../../package.json';

import BaseInput from '../../components/BaseInput';
import BaseButton from '../../components/BaseButton';
import Logo from '../../components/Logo';
import VersionDisplay from '../../components/VersionDisplay';

const Register = () => {
  const { push } = useHistory();
  const { id, code } = useParams();
  const { resetPassword } = useActions();
  const [form, setForm] = useState({ id, code, password: '' });

  const onSubmitHandler = async (event) => {
    event.preventDefault();
    resetPassword(form).then(() => push('/login'));
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
            label="Senha"
            placeholder="Digite sua senha nova"
            value={form.password}
            type="password"
            onChange={(password) => setForm({ ...form, password })}
          />
          <BaseButton label="Alterar senha" />
        </form>
      </main>

      <VersionDisplay version={packageJson.version} />
    </>
  );
};

export default Register;
