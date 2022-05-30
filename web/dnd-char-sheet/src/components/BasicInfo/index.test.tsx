import { render } from 'solid-testing-library';
import { BasicInfo } from './index';

describe('components/BasicInfo', () => {
  it('Should render without any props', async () => {
    const { container } = render(() => <BasicInfo />);
    expect(container.children.length).toBeGreaterThan(0);
  });
});
