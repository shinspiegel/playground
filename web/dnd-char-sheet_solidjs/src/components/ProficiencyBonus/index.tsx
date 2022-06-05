import type { Component } from 'solid-js';
import { proficiencyBonusStore } from '../../stores';
import styles from './index.module.scss';

export const ProficiencyBonus: Component = () => {
  const { proficiencyBonus, setProficiencyBonus } = proficiencyBonusStore();

  return (
    <div class={styles.container}>
      <label>
        Proficiency Bonus
        <input
          value={proficiencyBonus.value}
          onChange={(e) => setProficiencyBonus('value', parseInt(e.currentTarget.value))}
        />
      </label>
    </div>
  );
};
