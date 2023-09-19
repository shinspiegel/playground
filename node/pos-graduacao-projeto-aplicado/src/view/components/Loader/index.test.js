import React from 'react';
import '@testing-library/jest-dom/extend-expect';
import { render, fireEvent, wait } from '@testing-library/react';

import Loader from './index';

describe('comp/BottomMenu', () => {
  test('O componente deve renderizar corretamente', async () => {
    const { container } = render(<Loader isLoading={true} />);

    expect(container.children.length).toBe(1);

    const loader = container.getElementsByClassName('loader')[0];

    expect(loader.children.length).toBe(4);
  });

  test('O não deve ser renderizar', async () => {
    const { container } = render(<Loader isLoading={false} />);

    expect(container.children.length).toBe(0);
  });
});
