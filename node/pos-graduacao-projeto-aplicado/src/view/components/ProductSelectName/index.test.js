import React from 'react';
import '@testing-library/jest-dom/extend-expect';
import { render, fireEvent } from '@testing-library/react';

import ProductSelectName from './index';

describe('comp/ProductSelectName', () => {
  test('Deve renderizar corretamente', () => {
    const { getByDisplayValue } = render(<ProductSelectName initialValue='INITIAL' />);

    const input = getByDisplayValue('INITIAL');
    expect(input).toBeInTheDocument();
  });

  test('Deve alterar o valor e disparar a função', () => {
    const onChangeFunction = jest.fn();
    const { container } = render(
      <ProductSelectName onChange={onChangeFunction} initialValue='INITIAL' />,
    );

    const input = container.getElementsByTagName('input')[0];

    fireEvent.change(input, { target: { value: 'OTHER' } });
    fireEvent.blur(input);

    expect(onChangeFunction).toBeCalledTimes(1);
    expect(input.value).toBe('OTHER');
  });
});
