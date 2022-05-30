import { createStore } from 'solid-js/store';

export const basicInfoStore = () => {
  const [basicInfo, setBasicInfo] = createStore({
    name: 'Random Name',
    class: 'Wizard',
    subClass: 'Conjurer',
    race: 'Shifter',
    subRace: 'Long-tooth',
    experiencePoints: 999,
    level: 1,
    background: 'Sage',
    playerName: 'Shin',
    campaign: 'Shin',
  });

  return { basicInfo, setBasicInfo };
};
