import React from 'react';
import '@testing-library/jest-dom/extend-expect';
import { render, fireEvent, wait } from '@testing-library/react';
import { BrowserRouter } from 'react-router-dom';

import ShowNotification from './index';
import { ContextProvider } from '../../context/context';

describe('comp/ShowNotification', () => {
  test('Deve mostrar apenas uma notificação', async () => {
    const InitialState = {
      notification: [{ isError: true, id: '00', message: 'Alguma coisa deu errada!' }],
    };

    const { container } = render(
      <BrowserRouter>
        <ContextProvider initialContext={InitialState}>
          <ShowNotification />
        </ContextProvider>
      </BrowserRouter>,
      { container: document.body },
    );

    expect(container.querySelectorAll('.notification').length).toBe(1);
    expect(container.querySelectorAll('.notification-item').length).toBe(1);
  });

  test('Deve mostrar apenas três notificações', async () => {
    const InitialState = {
      notification: [
        { isError: true, id: '00', message: 'Alguma coisa deu errada!' },
        { isError: true, id: '00', message: 'Alguma coisa deu errada!' },
        { isError: true, id: '00', message: 'Alguma coisa deu errada!' },
      ],
    };

    const { container } = render(
      <BrowserRouter>
        <ContextProvider initialContext={InitialState}>
          <ShowNotification />
        </ContextProvider>
      </BrowserRouter>,
      { container: document.body },
    );

    expect(container.querySelectorAll('.notification').length).toBe(1);
    expect(container.querySelectorAll('.notification-item').length).toBe(3);
  });
});
