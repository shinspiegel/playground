import React from 'react';
import '@testing-library/jest-dom/extend-expect';
import { render, fireEvent, wait } from '@testing-library/react';
import { BrowserRouter } from 'react-router-dom';

import mockFetch from '../../tests/mockFetch';

import Login from './index';
import { ContextProvider } from '../../context/context';

beforeEach(() => {
  global.fetch = mockFetch();
});

describe('pages/Register', () => {
  test('Deve realizar um register e enviar para o fetch os dados corretos', async () => {
    const { getByPlaceholderText, getByRole } = render(
      <BrowserRouter>
        <ContextProvider>
          <Login />
        </ContextProvider>
      </BrowserRouter>,
    );

    const email = getByPlaceholderText('Digite seu email');
    const senha = getByPlaceholderText('Digite a senha');
    const button = getByRole('button');

    await wait(() => {
      fireEvent.change(email, { target: { value: 'EMAIL' } });
      fireEvent.change(senha, { target: { value: 'SENHA' } });
      fireEvent.click(button);
    });

    expect(global.fetch).toHaveBeenCalledWith('undefined/login', {
      body: '{"email":"EMAIL","password":"SENHA"}',
      headers: { 'Content-Type': 'application/json' },
      method: 'POST',
      mode: 'cors',
      redirect: 'follow',
    });
  });
});
