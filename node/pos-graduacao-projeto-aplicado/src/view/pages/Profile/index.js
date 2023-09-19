import React, { useState } from 'react';
import { useHistory } from 'react-router-dom';
import { motion } from 'framer-motion';
import './index.css';
import themeList from '../../assets/themes.json';

import BaseInput from '../../components/BaseInput';
import BaseButton from '../../components/BaseButton';
import ThemeButton from '../../components/ThemeButton';

import useActions from '../../context/useActions';
import { getWeekNumber } from '../../utils';
import VersionDisplay from '../../components/VersionDisplay';
import packageJson from '../../../../package.json';

const Profile = () => {
  const { push } = useHistory();
  const { state, updateUser, logout, changeTheme } = useActions();
  const { userData, userTheme } = state;

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

  const handleTheme = (theme) => {
    changeTheme({ theme, id: userData._id });
  };

  return (
    <>
      <motion.div
        initial={{ opacity: 0 }}
        animate={{ opacity: 1 }}
        exit={{ opacity: 0 }}
        className="profilePage"
      >
        <h3>
          <span>O que gostaria de alterar</span>
          {userData.name}
        </h3>

        <motion.form
          initial={{ top: 200 }}
          animate={{ top: 0 }}
          exit={{ top: -200 }}
          onSubmit={submitHandler}
        >
          <h4>Alterar dados</h4>
          <BaseInput
            onChange={(value) => setForm({ ...form, name: value })}
            value={form.name}
            label="Alterar nome"
          />
          <BaseInput
            onChange={(value) => setForm({ ...form, email: value })}
            value={form.email}
            label="Alterar e-mail"
            type="email"
          />
          <BaseInput
            onChange={(value) => setForm({ ...form, password: value })}
            value={form.password}
            label="Alterar senha"
            type="password"
          />
          <ul>
            {Object.keys(themeList).map((theme) => (
              <li key={theme}>
                {/* {console.log(userTheme.userTheme)} */}
                <ThemeButton
                  theme={theme}
                  themeColor={themeList[theme]['--primary-bg']}
                  isSelected={userTheme === theme}
                  onClick={() => handleTheme(theme)}
                />
              </li>
            ))}
          </ul>
          <BaseButton label="Salvar Alterações" />
        </motion.form>

        <BaseButton onClick={handleLogout} className="ghost" label="Logout" />
        <BaseButton onClick={handleBack} className="secondary" label="Voltar" />
      </motion.div>
      <VersionDisplay version={packageJson.version} />
    </>
  );
};

export default Profile;
