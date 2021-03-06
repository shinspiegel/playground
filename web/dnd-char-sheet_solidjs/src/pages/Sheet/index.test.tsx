import { render } from 'solid-testing-library';
import { Sheet } from './index';

describe('pages/Sheet', () => {
  it('Should render without any props', async () => {
    const { container } = render(() => <Sheet />);
    expect(container.children.length).toBeGreaterThan(0);
  });
});
