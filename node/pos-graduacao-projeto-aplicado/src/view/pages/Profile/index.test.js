import React from 'react';
import '@testing-library/jest-dom/extend-expect';
import { render, fireEvent, wait } from '@testing-library/react';
import { BrowserRouter } from 'react-router-dom';

import mockFetch from '../../tests/mockFetch';
import { setCookie } from '../../utils';

import Profile from './index';
import { ContextProvider } from '../../context/context';

beforeEach(() => {
  global.fetch = mockFetch();
});

describe('pages/Register', () => {
  test('Deve realizar um register e enviar para o fetch os dados corretos', async () => {
    const TOKEN = 'TOKEN_TEST';
    setCookie('user', { token: TOKEN });

    const initialContext = {
      notification: [],
      userTheme: 'dark',
      groceryList: [],
      userData: { _id: 'ID123', name: 'NAME', email: 'EMAIL@EMAIL', password: '123' },
    };

    const { getByPlaceholderText, getByRole, debug, getByLabelText, getByText } = render(
      <BrowserRouter>
        <ContextProvider initialContext={initialContext}>
          <Profile />
        </ContextProvider>
      </BrowserRouter>,
    );

    const name = getByLabelText('Alterar nome');
    const email = getByLabelText('Alterar e-mail');
    const senha = getByLabelText('Alterar senha');
    const button = getByText('Salvar Alterações');

    await wait(() => {
      fireEvent.change(name, { target: { value: 'NAME' } });
      fireEvent.change(email, { target: { value: 'EMAIL' } });
      fireEvent.change(senha, { target: { value: 'SENHA' } });
      fireEvent.click(button);
    });

    expect(global.fetch).toHaveBeenCalledWith('undefined/users/ID123', {
      body: '{"name":"NAME","email":"EMAIL","password":"SENHA"}',
      headers: {
        Authorization: 'TOKEN_TEST',
        'Content-Type': 'application/json',
      },
      method: 'PUT',
      mode: 'cors',
      redirect: 'follow',
    });
  });
});
