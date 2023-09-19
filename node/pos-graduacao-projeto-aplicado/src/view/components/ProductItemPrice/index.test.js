import React from 'react';
import '@testing-library/jest-dom/extend-expect';
import { render } from '@testing-library/react';

import ProductItemPrice from './index';

describe('comp/ProductItemPrice', () => {
  test('Deve renderizar um componente com preço', () => {
    const { getByText } = render(<ProductItemPrice price={123.45} />);

    const value = getByText('123,');
    const cents = getByText('45');

    expect(value).toBeInTheDocument();
    expect(cents).toBeInTheDocument();
    expect(value.innerHTML).toBe('123,');
    expect(cents.innerHTML).toBe('45');
  });

  test('Não deve renderizar nada', () => {
    const { container } = render(<ProductItemPrice />);

    expect(container.children.length).toBe(0);
  });
});
