import { Stat } from '../stores';
import { calculateMod } from './calculateMod';

describe('utils/calculateMod', () => {
  it('should calculate a simple', () => {
    const mod = calculateMod(10);
    expect(mod).toBe(0);
  });

  it('should calculate a big number', () => {
    const mod = calculateMod(20);
    expect(mod).toBe(5);
  });

  it('should calculate a odd number', () => {
    const mod = calculateMod(15);
    expect(mod).toBe(2);
  });

  it('should calculate a negative number', () => {
    const mod = calculateMod(8);
    expect(mod).toBe(-1);
  });

  it('should calculate a negative odd number', () => {
    const mod = calculateMod(7);
    expect(mod).toBe(-2);
  });
});
