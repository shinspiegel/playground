import { render } from 'solid-testing-library';
import { Sheet } from './index';

describe('Basic testing', () => {
  it('Should render', async () => {
    const { container } = render(() => <Sheet />);
    expect(container.children.length).toBeGreaterThan(0);
  });
});
