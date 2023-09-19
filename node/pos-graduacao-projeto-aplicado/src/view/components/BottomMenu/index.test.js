import React from 'react';
import '@testing-library/jest-dom/extend-expect';
import { render, fireEvent, wait } from '@testing-library/react';

import BottomMenu from './index';

describe('comp/BottomMenu', () => {
  test('O componente deve renderizar corretamente', async () => {
    const { container } = render(<BottomMenu />);

    expect(container.children.length).toBe(1);
  });

  test('O componente deve renderizar três divs internamente', () => {
    const { debug, container } = render(
      <BottomMenu>
        <div />
        <div />
        <div />
      </BottomMenu>,
    );

    const menu = container.getElementsByClassName('bottomMenu')[0];
    expect(menu.children.length).toBe(4);
  });

  test('O componente deve mudar sua classe quando clicar em seu span', () => {
    const { debug, container } = render(<BottomMenu />);

    const menu = container.getElementsByClassName('bottomMenu')[0];
    const spanButton = container.getElementsByTagName('span')[0];

    expect(menu.classList.contains('closed')).toBe(true);

    fireEvent.click(spanButton);

    expect(menu.classList.contains('opened')).toBe(true);
  });
});
