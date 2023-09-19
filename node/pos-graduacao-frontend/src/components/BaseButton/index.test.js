import React from 'react';
import '@testing-library/jest-dom/extend-expect';
import { render, fireEvent, wait } from '@testing-library/react';

import BaseButton from './index';

describe('comp/BaseButton', () => {
  test('Renderiza corretamente', () => {
    const ButtonText = 'TEST';
    const { getByText } = render(<BaseButton label={ButtonText} />);

    const Button = getByText(ButtonText);
    expect(Button).toBeInTheDocument();
  });

  test('Possui o "type" correto', () => {
    const ButtonText = 'TEST';
    const ButtonType = 'button';
    const { getByText } = render(<BaseButton label={ButtonText} type={ButtonType} />);

    const Button = getByText(ButtonText);
    expect(Button.type).toBe(ButtonType);
  });

  test('Possui o "type" correto mesmo quando recebendo type errado', () => {
    const ButtonText = 'TEST';
    const ButtonType = 'fail';
    const { getByText } = render(<BaseButton label={ButtonText} type={ButtonType} />);

    const Button = getByText(ButtonText);
    expect(Button.type).toBe('submit');
  });
});
