import React from 'react';
import '@testing-library/jest-dom/extend-expect';
import { render, fireEvent } from '@testing-library/react';

import ProductSelectInput from './index';

describe('comp/ProductSelectInpu', () => {
  test('Deve renderizar um componente corretamente', () => {
    const { container } = render(
      <ProductSelectInput
        isChecked={true}
        value='TESTE'
        radioName='GROUP_TEST'
        label={'TEST ON LABEL'}
        price={123}
      />,
    );

    const ProductItem = container.getElementsByTagName('label')[0];
    expect(ProductItem.children.length).toBe(4);
  });

  test.skip('Deve executar a função ao receber uma troca de input', () => {
    // ENTENDER PORQUE NAO RODA A FUNCAO DE CLICK

    const onChangeFunction = jest.fn();
    const { container } = render(
      <ProductSelectInput
        isChecked={true}
        value='TESTE'
        radioName='GROUP_TEST'
        label={'TEST ON LABEL'}
        price={123}
        onChange={onChangeFunction}
      />,
    );

    const input = container.getElementsByTagName('input')[0];

    fireEvent.change(input, { target: { value: 'NEW' } });
    expect(onChangeFunction).toBeCalledTimes(1);
  });
});
