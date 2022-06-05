import { Stat } from '../stores';
import { statSort } from './statSort';

describe('utils/statSort', () => {
  it('should make a simple sort', () => {
    const list = [
      { order: 1, name: 'A', short: 'a', value: 0, mod: 0 },
      { order: 0, name: 'B', short: 'b', value: 0, mod: 0 },
    ];

    const ordered = list.sort(statSort);

    expect(ordered[0].name).toBe('B');
  });

  it('if the same order should use the name', () => {
    const list = [
      { order: 0, name: 'B', short: 'b', value: 0, mod: 0 },
      { order: 0, name: 'A', short: 'a', value: 0, mod: 0 },
    ];

    const ordered = list.sort(statSort);

    expect(ordered[0].name).toBe('A');
  });
});
