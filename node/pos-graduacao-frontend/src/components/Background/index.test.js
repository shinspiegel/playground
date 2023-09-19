import React from 'react';
import '@testing-library/jest-dom/extend-expect';
import { render, fireEvent, wait } from '@testing-library/react';
import { BrowserRouter } from 'react-router-dom';

import Background from './index';
import { ContextProvider } from '../../context/context';

describe('comp/Background', () => {
  test('Renderiza corretamente', () => {
    const { container } = render(
      <BrowserRouter>
        <ContextProvider initialContext={{ backgroundURL: 'TESTE' }}>
          <Background />
        </ContextProvider>
      </BrowserRouter>,
    );

    expect(container.children.length).toBe(2);
  });

  test('Renderiza com os props corretamente', () => {
    const { container } = render(
      <BrowserRouter>
        <ContextProvider initialContext={{ backgroundURL: 'TESTE' }}>
          <Background image='test' color='#000' />
        </ContextProvider>
      </BrowserRouter>,
    );

    const ColorDiv = container.children[0];
    const ImageDiv = container.children[1];

    expect(ColorDiv).toHaveStyle(`background-color: rgb(0, 0, 0)`);
    expect(ImageDiv).toHaveStyle(`background-image: url('TESTE')`);
  });
});
