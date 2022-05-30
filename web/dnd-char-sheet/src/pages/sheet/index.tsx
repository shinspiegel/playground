import type { Component } from 'solid-js';
import { BasicInfo } from '../../components';
import styles from './index.module.scss';

export const Sheet: Component = () => (
  <main class={styles.container}>
    <div class={styles.basicInfo}>
      <BasicInfo />
    </div>
    <div class={styles.combatStats}>combatStats</div>
    <div class={styles.traits}>traits</div>
    <div class={styles.profBonus}>profBonus</div>
    <div class={styles.savingThrow}>savingThrow</div>
    <div class={styles.baseStats}>baseStats</div>
    <div class={styles.attacks}>attacks</div>
    <div class={styles.skills}>skills</div>
  </main>
);
