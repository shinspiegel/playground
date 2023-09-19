import React, { useState } from 'react';
import './index.scss';
import useActions from '../../context/useActions';

import Header from '../../components/Header';
import StatBlock from '../../components/StatBlock';
import LuckBox from '../../components/LuckBox';
import DamageBox from '../../components/DamageBox';
import TextBlock from '../../components/TextBlock';
import AppearanceBox from '../../components/AppearanceBox';
import RadioList from '../../components/RadioList';
import ListItem from '../../components/ListItem';
import LevelUp from '../../components/LevelUp';
import CheckBoxList from '../../components/CheckboxList';
import CombatMagic from '../../components/CombatMagic';
import Moves from '../../components/Moves';

const Home = () => {
  const { state, setStats, setOneStat } = useActions();
  const {
    header,
    stats,
    luckBox,
    damageBox,
    charCreation,
    levelUp,
    upgrades,
    advancedUpgrades,
    combatMagic,
    moves,
    equips,
  } = state;

  const handleHeaderStatChange = (value, index) => {
    setOneStat(value, index);
  };

  const handleBaseStats = (index) => {
    setStats(index);
  };

  return (
    <main className="home">
      <article className="home__article home__article--info">
        <Header
          title={header.title}
          subTitle={header.subTitle}
          placeholder={header.placeholder}
          initialValue={header.value}
          onChange={header.onChange}
        />
        <StatBlock statsList={stats} onChange={handleHeaderStatChange} />
        <LuckBox
          title={luckBox.title}
          description={luckBox.description}
          initialValue={luckBox.value}
          onChange={luckBox.onChange}
        />
        <DamageBox
          title={damageBox.title}
          description={damageBox.description}
          healthValue={damageBox.health}
          healthChange={damageBox.healthChange}
          isInstable={damageBox.isInstable}
          instableChange={damageBox.instableChange}
        />
      </article>
      <article className="home__article home__article--creation">
        <TextBlock
          title={charCreation.intro.title}
          description={charCreation.intro.description}
        />
        <AppearanceBox
          title={charCreation.appearance.title}
          sexList={charCreation.appearance.lists.sex}
          eyesList={charCreation.appearance.lists.eyes}
          clothesList={charCreation.appearance.lists.clothes}
        />
        <RadioList
          title={charCreation.baseStats.title}
          options={charCreation.baseStats.lists}
          onChange={handleBaseStats}
        />
        <TextBlock
          title={charCreation.presentation.title}
          description={charCreation.presentation.description}
        />
        <ListItem
          title={charCreation.history.title}
          description={charCreation.history.description}
          options={charCreation.history.options}
        />
      </article>
      <article className="home__article home__article--levelUp">
        <LevelUp
          title={levelUp.title}
          label={levelUp.label}
          descriptionList={levelUp.descriptionList}
          initialValue={0}
          onChange={levelUp.onChange}
        />
        <CheckBoxList
          title={upgrades.title}
          description={upgrades.description}
          options={upgrades.options}
        />
        <CheckBoxList
          title={advancedUpgrades.title}
          options={advancedUpgrades.options}
        />
      </article>
      <article className="home__article home__article--combat">
        <CombatMagic
          title={combatMagic.title}
          descriptionList={combatMagic.descriptionList}
          base={combatMagic.base}
          effect={combatMagic.effect}
        />
        <Moves
          title={moves.title}
          descriptionList={moves.descriptionList}
          defaultText={moves.defaultText}
          defaultList={moves.default}
          movesListText={moves.movesListText}
          movesList={moves.movesList}
        />
        <RadioList
          title={equips.title}
          description={equips.description}
          options={equips.options}
        />
      </article>
    </main>
  );
};

export default Home;
