import type { Component } from 'solid-js';
import { basicInfoStore } from '../../stores';
import styles from './index.module.scss';

export const BasicInfo: Component = () => {
  const { basicInfo, setBasicInfo } = basicInfoStore();

  const handleChange = (key: keyof typeof basicInfo, value: string) => {
    setBasicInfo(key, value);
  };

  return (
    <div class={styles.container}>
      <label>{basicInfo.name}</label>

      <label>
        <span>Class and Level</span>
        <input value={basicInfo.class} onChange={(e) => handleChange('class', e.currentTarget.value)} />
        <input value={basicInfo.subClass} onChange={(e) => handleChange('subClass', e.currentTarget.value)} />
        <input value={basicInfo.level} onChange={(e) => handleChange('level', e.currentTarget.value)} />
      </label>

      <label>
        <span>Race</span>
        <input value={basicInfo.race} onChange={(e) => handleChange('race', e.currentTarget.value)} />
        <input value={basicInfo.subRace} onChange={(e) => handleChange('subRace', e.currentTarget.value)} />
      </label>

      <label>
        <span>Background</span>
        <input value={basicInfo.background} onChange={(e) => handleChange('background', e.currentTarget.value)} />
      </label>

      <label>
        <span>Experience Points</span>
        <input
          value={basicInfo.experiencePoints}
          onChange={(e) => handleChange('experiencePoints', e.currentTarget.value)}
        />
      </label>

      <label>
        <span>Player / Campaign</span>
        <input value={basicInfo.playerName} onChange={(e) => handleChange('playerName', e.currentTarget.value)} />
        <input value={basicInfo.campaign} onChange={(e) => handleChange('campaign', e.currentTarget.value)} />
      </label>
    </div>
  );
};
