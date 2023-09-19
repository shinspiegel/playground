import React from 'react';
import '@testing-library/jest-dom/extend-expect';
import { render } from '@testing-library/react';

import ProductItemArrow from './index';

describe('comp/ProductItemArrow', () => {
  test('Deve renderizar corretamente um SVG', () => {
    const { container } = render(<ProductItemArrow />);

    expect(container.children.length).toBe(1);
    expect(container.children[0].nodeName).toBe('SPAN');
    expect(container.children[0].children[0].nodeName).toBe('svg');
  });
});
