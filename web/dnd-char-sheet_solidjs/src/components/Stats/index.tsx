import { For } from 'solid-js';
import type { Component } from 'solid-js';
import { statsStore } from '../../stores';
import { statSort } from '../../utils';
import styles from './index.module.scss';

export const Stats: Component = () => {
  const { stats, updateValue, updateMod } = statsStore();
  const ordered = [...stats].sort(statSort);

  return (
    <div class={styles.container}>
      <For each={ordered}>
        {(stat) => (
          <div>
            <div>{stat.name}</div>
            <input value={stat.value} onChange={(e) => updateValue(stat.name, parseInt(e.currentTarget.value))} />
            <input value={stat.mod} onChange={(e) => updateMod(stat.name, parseInt(e.currentTarget.value))} />
          </div>
        )}
      </For>
    </div>
  );
};
