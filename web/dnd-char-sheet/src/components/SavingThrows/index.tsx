import { For, createEffect } from 'solid-js';
import type { Component } from 'solid-js';
import { proficiencyBonusStore, statsStore } from '../../stores';
import { calculateSaveThrow } from '../../utils/calculateSaveThrow';
import { statSort } from '../../utils';
import styles from './index.module.scss';

export const SavingThrows: Component = () => {
  const { stats, updateSaveThrowProf } = statsStore();
  const { proficiencyBonus } = proficiencyBonusStore();
  const ordered = [...stats].sort(statSort);

  createEffect(() => {
    console.log('INFO:: ', calculateSaveThrow({ stat: ordered[0], proficiency: proficiencyBonus.value }));
  });

  return (
    <div class={styles.container}>
      <For each={ordered}>
        {(stat) => (
          <div>
            <div>{stat.name}</div>
            <input
              type='checkbox'
              checked={stat.isSaveProf}
              onChange={() => updateSaveThrowProf(stat.name, !stat.isSaveProf)}
            />
            <input type='text' value={calculateSaveThrow({ stat, proficiency: proficiencyBonus.value })} disabled />
          </div>
        )}
      </For>
    </div>
  );
};
