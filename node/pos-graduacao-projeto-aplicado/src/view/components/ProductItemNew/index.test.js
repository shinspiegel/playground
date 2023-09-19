import React from 'react';
import '@testing-library/jest-dom/extend-expect';
import { render, fireEvent } from '@testing-library/react';

import ProductItemNew from './index';

describe('comp/ProductItemNew', () => {
  test('Deve renderizar o componente corretamente', () => {
    const { container } = render(<ProductItemNew />);

    const form = container.querySelector('form.productItemNew');
    expect(form.children.length).toBe(2);
  });

  test('Deve receber um input e disparar uma função e limpar o input digitado', async () => {
    const click = jest.fn();
    const { container } = render(<ProductItemNew onClick={click} />);

    const input = container.querySelector('input');
    const button = container.querySelector('button');

    fireEvent.change(input, { target: { value: '123' } });
    expect(input.value).toBe('123');

    fireEvent.click(button);
    expect(input.value).toBe('');

    expect(click).toBeCalledTimes(1);
  });
});
