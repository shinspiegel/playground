import React from 'react';
import '@testing-library/jest-dom/extend-expect';
import { render, fireEvent, wait } from '@testing-library/react';

import ThemeButton from './index';

describe('comp/ThemeButton', () => {
  test('O componente deve renderizar sem propriedades', async () => {
    const { container, debug } = render(<ThemeButton />);

    const button = container.getElementsByTagName('label')[0];
    button.click();

    expect(button).toBeInTheDocument();
  });

  test('O componente deve renderizar com propriedades e pode receber eventos de click', async () => {
    const mockClick = jest.fn();

    const { container } = render(
      <ThemeButton onClick={mockClick} isSelected={true} themeColor="#fff" />,
    );

    const button = container.getElementsByTagName('label')[0];

    expect(button).toBeInTheDocument();

    button.click();

    expect(mockClick).toBeCalledTimes(1);
  });
});
