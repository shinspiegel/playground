import React from 'react';
import '@testing-library/jest-dom/extend-expect';
import { render } from '@testing-library/react';

import ProductItem from './index';

describe('comp/ProductItem', () => {
  test('Deve renderizar um item simples, sem referencia', () => {
    const sampleProduct = { productName: 'TESTE_NAME' };
    const { container } = render(<ProductItem product={sampleProduct} />);

    const input = container.querySelector('input');

    expect(input).toBeInTheDocument();
    expect(input.value).toBe('TESTE_NAME');
  });

  test('Deve renderizar um item complexo, com referencia', () => {
    const sampleProduct = { productName: 'TESTE_NAME', productReference: { price: 123.45 } };
    const { container, getByText } = render(<ProductItem product={sampleProduct} />);

    const input = container.querySelector('input');
    const value = getByText('123,');
    const cents = getByText('45');

    expect(input).toBeInTheDocument();
    expect(value).toBeInTheDocument();
    expect(cents).toBeInTheDocument();
    expect(input.value).toBe('TESTE_NAME');
    expect(value.innerHTML).toBe('123,');
    expect(cents.innerHTML).toBe('45');
  });
});
