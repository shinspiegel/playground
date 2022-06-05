import { Stat } from '../stores';
import { calculateStat } from './calculateStat';

describe('utils/calculateMod', () => {
  it('should calculate a simple', () => {
    const mod = calculateStat(0);
    expect(mod).toBe(10);
  });

  it('should calculate a big number', () => {
    const mod = calculateStat(5);
    expect(mod).toBe(20);
  });

  it('should calculate a negative number', () => {
    const mod = calculateStat(-1);
    expect(mod).toBe(8);
  });

  it('should calculate a big negative number', () => {
    const mod = calculateStat(-3);
    expect(mod).toBe(4);
  });
});
