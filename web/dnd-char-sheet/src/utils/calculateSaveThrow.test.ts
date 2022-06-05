import { Stat } from '../stores';
import { calculateSaveThrow } from './calculateSaveThrow';

describe('utils/calculateSaveThrow', () => {
  const baseStat: Stat = { name: 'Base', short: 'BAS', value: 15, mod: 2, order: 0, isSaveProf: false };
  const profStat: Stat = { name: 'Base', short: 'BAS', value: 15, mod: 2, order: 0, isSaveProf: true };

  it('should not add proficiency on an not save proficiency throw', () => {
    const save = calculateSaveThrow({ stat: baseStat, proficiency: 2 });
    expect(save).toBe(2);
  });

  it('should add proficiency on an not save proficiency throw', () => {
    const save = calculateSaveThrow({ stat: profStat, proficiency: 2 });
    expect(save).toBe(4);
  });
});
