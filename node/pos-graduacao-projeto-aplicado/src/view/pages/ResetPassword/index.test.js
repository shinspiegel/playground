import React from 'react';
import '@testing-library/jest-dom/extend-expect';
import { render, fireEvent, wait } from '@testing-library/react';
import { BrowserRouter } from 'react-router-dom';

import mockFetch from '../../tests/mockFetch';

import ResetPassword from './index';
import { ContextProvider } from '../../context/context';

beforeEach(() => {
  global.fetch = mockFetch();
});

describe('pages/Register', () => {
  test('Deve realizar um update no password e enviar para o fetch os dados corretos', async () => {
    const { getByPlaceholderText, getByRole } = render(
      <BrowserRouter>
        <ContextProvider>
          <ResetPassword />
        </ContextProvider>
      </BrowserRouter>,
    );

    const senha = getByPlaceholderText('Digite sua senha nova');
    const button = getByRole('button');

    await wait(() => {
      fireEvent.change(senha, { target: { value: 'SENHA' } });
      fireEvent.click(button);
    });

    expect(global.fetch).toHaveBeenCalledWith('undefined/recover', {
      body: '{"password":"SENHA"}',
      headers: { 'Content-Type': 'application/json' },
      method: 'POST',
      mode: 'cors',
      redirect: 'follow',
    });
  });
});
