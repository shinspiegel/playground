import React from 'react';
import '@testing-library/jest-dom/extend-expect';
import { render, fireEvent } from '@testing-library/react';
import { BrowserRouter } from 'react-router-dom';

import Main from './index';
import { ContextProvider } from '../../context/context';

describe('Basic test', () => {
  test.skip('Test click on the button and change the state', () => {
    const { getByText } = render(
      <BrowserRouter>
        <ContextProvider>
          <Main />
        </ContextProvider>
      </BrowserRouter>,
    );

    const increaseButton = getByText('Increase');
    const pTag = getByText('0');

    fireEvent.click(increaseButton);
    expect(pTag.textContent).toBe('1');
  });
});
