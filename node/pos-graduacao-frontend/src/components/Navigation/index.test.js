import React from 'react';
import '@testing-library/jest-dom/extend-expect';
import { render, fireEvent, wait } from '@testing-library/react';

import Navigation from './index';

describe('comp/Navigation', () => {
  test('Não deve renderizar nenhum componente', async () => {
    const { container } = render(<Navigation />);
    expect(container.children.length).toBe(0);
  });

  test('Deve renderizar um componente com valores corretamente', async () => {
    const { getByRole, getAllByRole } = render(<Navigation weekNumber={3} price={123.34} />);

    const button = getAllByRole('button');
    expect(button[0].className).toBe('navigation-arrowLeft');
    expect(button[1].className).toBe('navigation-arrowRight');

    const nav = getByRole('navigation');
    expect(nav.children[2].innerHTML).toContain('3');
    expect(nav.children[3].innerHTML).toContain('123');
    expect(nav.children[3].innerHTML).toContain('34');
  });

  test('Deve receber um evento de click em cada arrow clickada', async () => {
    const leftArrowFunction = jest.fn();
    const rightArrowFunction = jest.fn();
    const { getAllByRole } = render(
      <Navigation
        weekNumber={3}
        price={123.34}
        onClickNext={rightArrowFunction}
        onClickPrev={leftArrowFunction}
      />,
    );

    const button = getAllByRole('button');
    expect(button[0].className).toBe('navigation-arrowLeft');
    expect(button[1].className).toBe('navigation-arrowRight');

    fireEvent.click(button[0]);
    fireEvent.click(button[1]);

    expect(leftArrowFunction).toBeCalledTimes(1);
    expect(rightArrowFunction).toBeCalledTimes(1);
  });
});
