import React, { useState } from 'react';
import { useHistory } from 'react-router-dom';
import './index.css';

import BaseInput from '../../components/BaseInput';
import BaseButton from '../../components/BaseButton';

import useActions from '../../context/useActions';
import { getWeekNumber } from '../../utils';
import VersionDisplay from '../../components/VersionDisplay';
import packageJson from '../../../package.json';

const Profile = () => {
  const { push } = useHistory();
  const { state, updateUser, logout } = useActions();
  const { userData } = state;

  if (!userData) return null;

  const [form, setForm] = useState({ ...userData, password: '' });

  const submitHandler = async (e) => {
    e.preventDefault();
    const updated = await updateUser(form);
    if (updated) handleBack();
  };

  const handleBack = () => {
    const year = new Date().getFullYear();
    const week = getWeekNumber();
    push(`/list/${year}/${week}`);
  };

  const handleLogout = () => {
    logout();
  };

  return (
    <>
      <div className='profilePage'>
        <h3>
          <span>O que gostaria de alterar</span>
          {userData.name}
        </h3>

        <form onSubmit={submitHandler}>
          <h4>Alterar dados</h4>
          <BaseInput
            onChange={(value) => setForm({ ...form, name: value })}
            value={form.name}
            label='Alterar nome'
          />
          <BaseInput
            onChange={(value) => setForm({ ...form, email: value })}
            value={form.email}
            label='Alterar e-mail'
            type='email'
          />
          <BaseInput
            onChange={(value) => setForm({ ...form, password: value })}
            value={form.password}
            label='Alterar senha'
            type='password'
          />
          <BaseButton label='Salvar Alterações' className='secondary' />
        </form>

        <BaseButton onClick={handleLogout} className='ghost secondary' label='Logout' />
        <BaseButton onClick={handleBack} className='' label='Voltar' />
      </div>
      <VersionDisplay version={packageJson.version} />
    </>
  );
};

export default Profile;
