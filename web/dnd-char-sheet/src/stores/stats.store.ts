import { createStore } from 'solid-js/store';
import { calculateMod } from '../utils/calculateMod';
import { calculateStat } from '../utils/calculateStat';

export type Stat = {
  order: number;
  name: string;
  short: string;
  value: number;
  mod: number;
};

export const statsStore = () => {
  const [stats, setStats] = createStore<Stat[]>([
    { order: 0, name: 'Strength', short: 'STR', value: 10, mod: 0 },
    { order: 1, name: 'Dexterity', short: 'DEX', value: 11, mod: 0 },
    { order: 2, name: 'Constitution', short: 'CON', value: 12, mod: 1 },
    { order: 3, name: 'Intelligence', short: 'INT', value: 13, mod: 1 },
    { order: 4, name: 'Wisdom', short: 'WIS', value: 14, mod: 2 },
    { order: 5, name: 'Charisma', short: 'CHA', value: 15, mod: 2 },
  ]);

  const updateValue = (name: string, value: number) => {
    setStats((s) => s.name === name, 'value', value);
    setStats((s) => s.name === name, 'mod', calculateMod(value));
  };

  const updateMod = (name: string, mod: number) => {
    setStats((s) => s.name === name, 'value', calculateStat(mod));
    setStats((s) => s.name === name, 'mod', mod);
  };

  return { stats, setStats, updateValue, updateMod };
};
