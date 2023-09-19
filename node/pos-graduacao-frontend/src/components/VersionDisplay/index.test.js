import React from 'react';
import '@testing-library/jest-dom/extend-expect';
import { render } from '@testing-library/react';

import VersionDisplay from './index';

describe('comp/VersionDisplay', () => {
  test('Deve renderizar corretamente um componente', () => {
    const { getByText } = render(<VersionDisplay version={'9.9.9'} />);
    const version = getByText('9.9.9');

    expect(version).toBeInTheDocument();
    expect(version.innerHTML).toBe('9.9.9');
  });
});
