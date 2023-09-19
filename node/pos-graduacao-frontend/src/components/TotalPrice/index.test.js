import React from 'react';
import '@testing-library/jest-dom/extend-expect';
import { render } from '@testing-library/react';

import TotalPrice from './index';

describe('pages/Login', () => {
  test('Deve renderizar o valor R$123,45', async () => {
    const { container } = render(<TotalPrice price={123.45} />);

    const PriceTag = container.children[0];

    expect(PriceTag.children.length).toBe(3);
    expect(PriceTag.children[0].innerHTML).toBe('R$');
    expect(PriceTag.children[1].innerHTML).toBe('123,');
    expect(PriceTag.children[2].innerHTML).toBe('45');
  });

  test('Não deve renderizar nenhum elemento', async () => {
    const { container } = render(<TotalPrice />);

    expect(container.children.length).toBe(0);
  });
});
