import { createStore } from 'solid-js/store';

export type ProficiencyBonus = {
  value: number;
};

export const proficiencyBonusStore = () => {
  const [proficiencyBonus, setProficiencyBonus] = createStore<ProficiencyBonus>({ value: 0 });

  return { proficiencyBonus, setProficiencyBonus };
};
