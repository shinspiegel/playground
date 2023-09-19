import React from 'react';
import '@testing-library/jest-dom/extend-expect';
import { render, fireEvent, wait } from '@testing-library/react';
import { BrowserRouter } from 'react-router-dom';

import mockFetch from '../../tests/mockFetch';

import Recover from './index';
import { ContextProvider } from '../../context/context';

beforeEach(() => {
  global.fetch = mockFetch();
});

describe('pages/Register', () => {
  test('Deve realizar um recover e enviar para o fetch os dados corretos', async () => {
    const { getByPlaceholderText, getByRole } = render(
      <BrowserRouter>
        <ContextProvider>
          <Recover />
        </ContextProvider>
      </BrowserRouter>,
    );

    const email = getByPlaceholderText('Digite seu email para recuperar');
    const button = getByRole('button');

    await wait(() => {
      fireEvent.change(email, { target: { value: 'EMAIL' } });
      fireEvent.click(button);
    });

    expect(global.fetch).toHaveBeenCalledWith('undefined/recover?emailEMAIL');
  });
});
