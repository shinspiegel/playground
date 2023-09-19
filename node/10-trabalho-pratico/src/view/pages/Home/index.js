import React, { useState } from 'react';
import './index.scss';
import useActions from '../../context/useActions';

import Header from '../../components/Header';
import StatBlock from '../../components/StatBlock';
import LuckBox from '../../components/LuckBox';
import DamageBox from '../../components/DamageBox';
import RadioList from '../../components/RadioList';
import LevelUp from '../../components/LevelUp';
import CheckBoxList from '../../components/CheckboxList';
import CombatMagic from '../../components/CombatMagic';
import Moves from '../../components/Moves';

const Home = () => {
  const {
    state,
    setStats,
    setOneStat,
    setAttributeValue,
    setAppearanceValue,
    setAttributeSelected,
    setCombatMagic,
    setMovesList,
  } = useActions();
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

  const handleBaseStats = (textValue) => {
    setStats(textValue);
  };

  const handleAtributesValues = (attribute, value) => {
    setAttributeValue(attribute, value);
  };

  const handleAppearance = (type, value) => {
    setAppearanceValue(type, value);
  };

  const handleCheckboxValues = (attribute, value) => {
    setAttributeSelected(attribute, value);
  };

  const handleCombatMagic = (type, value) => {
    setCombatMagic(type, value);
  };

  const handleMoves = (value) => {
    setMovesList(value);
  };

  return (
    <main className="home">
      <article className="home__article">
        <Header
          title={header.title}
          subTitle={header.subTitle}
          placeholder={header.placeholder}
          initialValue={header.value}
          onChange={(t) => handleAtributesValues('header', t)}
        />
        <StatBlock statsList={stats} onChange={handleHeaderStatChange} />
        <LuckBox
          title={luckBox.title}
          description={luckBox.description}
          initialValue={luckBox.value}
          onChange={(v) => handleAtributesValues('luckBox', v)}
        />
        <DamageBox
          title={damageBox.title}
          description={damageBox.description}
          healthValue={damageBox.value}
          healthChange={(v) => handleAtributesValues('damageBox', v)}
        />
        <LevelUp
          title={levelUp.title}
          label={levelUp.label}
          descriptionList={levelUp.descriptionList}
          initialValue={levelUp.value}
          onChange={(v) => handleAtributesValues('levelUp', v)}
        />
        <CheckBoxList
          title={upgrades.title}
          description={upgrades.description}
          options={upgrades.options}
          initialValue={upgrades.selected}
          onChange={(value) => handleCheckboxValues('upgrades', value)}
        />
        <CheckBoxList
          title={advancedUpgrades.title}
          initialValue={advancedUpgrades.selected}
          options={advancedUpgrades.options}
          onChange={(value) => handleCheckboxValues('advancedUpgrades', value)}
        />
      </article>
      <article className="home__article">
        <CombatMagic
          title={combatMagic.title}
          descriptionList={combatMagic.descriptionList}
          base={combatMagic.base}
          baseChange={(v) => handleCombatMagic('base', v)}
          effect={combatMagic.effect}
          effectChange={(v) => handleCombatMagic('effect', v)}
        />
        <RadioList
          title={equips.title}
          description={equips.description}
          options={equips.options}
          onChange={(v) => handleAtributesValues('equips', v)}
        />
      </article>
      <article className="home__article">
        <Moves
          title={moves.title}
          descriptionList={moves.descriptionList}
          defaultText={moves.defaultText}
          defaultList={moves.default}
          movesListText={moves.movesListText}
          movesList={moves.movesList}
          onChange={(v) => handleMoves(v)}
        />
      </article>
    </main>
  );
};

export default Home;
