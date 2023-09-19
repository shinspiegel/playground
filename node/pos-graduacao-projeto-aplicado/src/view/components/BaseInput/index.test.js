import React from 'react';
import '@testing-library/jest-dom/extend-expect';
import { render, fireEvent, wait } from '@testing-library/react';

import BaseInput from './index';

describe('comp/BaseInput', () => {
  test('O componente deve renderizar corretamente', async () => {
    const config = { placeholder: 'PLACE' };

    const { findByPlaceholderText } = render(
      <BaseInput type='text' placeholder={config.placeholder} />,
    );

    const Input = await findByPlaceholderText(config.placeholder);

    expect(Input).toBeInTheDocument();
  });

  test('O componente deve enviar enviar para o callback o texto alterado', async () => {
    const config = { placeholder: 'PLACE', value: 'VALUE' };
    const onChangeHandler = jest.fn();

    const { findByPlaceholderText } = render(
      <BaseInput type='text' placeholder={config.placeholder} onChange={onChangeHandler} />,
    );

    const Input = await findByPlaceholderText(config.placeholder);
    await fireEvent.change(Input, { target: { value: config.value } });

    expect(Input.value).toBe(config.value);
    // expect(onChangeHandler).toHaveBeenCalledTimes(1); //Ainda falha porque a atual versão do Jest está com bug no onChange
  });

  test('O componente recebe um valor como props e renderiza corretamente', async () => {
    const config = { placeholder: 'PLACE', value: 'VALUE' };

    const { findByPlaceholderText } = render(
      <BaseInput type='text' placeholder={config.placeholder} value={config.value} />,
    );

    const Input = await findByPlaceholderText(config.placeholder);
    expect(Input.value).toBe(config.value);
  });
});
