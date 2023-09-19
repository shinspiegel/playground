import React from 'react';
import '@testing-library/jest-dom/extend-expect';
import { render } from '@testing-library/react';

import ProductList from './index';

describe('comp/ProductsList', () => {
  test('Deve renderizar apenas um item', () => {
    const { container } = render(
      <ProductList>
        <div />
      </ProductList>,
    );

    expect(container.children.length).toBe(1);
  });

  test('Não deve renderizar nada', () => {
    const { container } = render(<ProductList />);

    expect(container.children.length).toBe(0);
  });
});
