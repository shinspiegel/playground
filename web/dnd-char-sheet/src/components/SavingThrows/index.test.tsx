import { render } from 'solid-testing-library';
import { SavingThrows } from './index';

describe('components/BasicInfo', () => {
  it('Should render without any props', async () => {
    const { container } = render(() => <SavingThrows />);
    expect(container.children.length).toBeGreaterThan(0);
  });
});
