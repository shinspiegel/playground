import React from 'react';
import '@testing-library/jest-dom/extend-expect';
import { render, fireEvent } from '@testing-library/react';

import BottomMenuItem from './index';

describe('comp/BaseInput', () => {
  test('O componente deve renderizar corretamente', async () => {
    const { container } = render(
      <BottomMenuItem label='TESTE' onClick={() => {}} icon={() => <i className='ICON' />} />,
    );

    const button = container.getElementsByClassName('bottomMenuItem')[0];
    expect(button.children.length).toBe(2);
  });

  test('Quando clickar no botão deve disparar a função', async () => {
    const clickEvent = jest.fn();

    const { container } = render(
      <BottomMenuItem label='TESTE' onClick={clickEvent} icon={() => <i className='ICON' />} />,
    );

    const button = container.getElementsByClassName('bottomMenuItem')[0];
    fireEvent.click(button);

    expect(clickEvent).toBeCalledTimes(1);
  });
});
