import { render } from 'solid-testing-library';
import { Stats } from './index';

describe('components/BasicInfo', () => {
  it('Should render without any props', async () => {
    const { container } = render(() => <Stats />);
    expect(container.children.length).toBeGreaterThan(0);
  });
});
