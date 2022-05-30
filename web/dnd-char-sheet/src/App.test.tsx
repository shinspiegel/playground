import { render, screen } from 'solid-testing-library';
import App from './App';

describe('Basic testing', () => {
  it('Should render', async () => {
    const { container } = render(() => <App />);
    expect(container.children.length).toBeGreaterThan(0);
  });
});
