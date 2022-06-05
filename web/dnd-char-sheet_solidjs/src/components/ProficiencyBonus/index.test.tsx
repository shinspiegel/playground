import { render } from 'solid-testing-library';
import { ProficiencyBonus } from './index';

describe('components/BasicInfo', () => {
  it('Should render without any props', async () => {
    const { container } = render(() => <ProficiencyBonus />);
    expect(container.children.length).toBeGreaterThan(0);
  });
});
