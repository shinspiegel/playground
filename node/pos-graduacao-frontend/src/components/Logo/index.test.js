import React from 'react';
import '@testing-library/jest-dom/extend-expect';
import { render, fireEvent, wait } from '@testing-library/react';

import Logo from './index';

describe('comp/Logo', () => {
  test('O componente deve renderizar corretamente', async () => {
    const { getByRole } = render(<Logo />);
    const Image = getByRole('img');

    expect(Image).toBeInTheDocument();
  });

  test('Recebe props corretamente', async () => {
    const { getByRole } = render(<Logo size={3} white />);
    const Image = getByRole('img');

    expect(Image.alt).toBe('MeuMercado - Suas compras facilitadas');
    expect(Image.className).toBe('imageLogo');
  });
});
