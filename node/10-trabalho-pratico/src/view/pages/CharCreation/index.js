import React, { useState } from 'react';
import './index.scss';
import useActions from '../../context/useActions';

import Header from '../../components/Header';
import TextBlock from '../../components/TextBlock';
import AppearanceBox from '../../components/AppearanceBox';
import RadioList from '../../components/RadioList';
import ListItem from '../../components/ListItem';
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
  const { header, charCreation, combatMagic, moves, equips } = state;

  const handleBaseStats = (index) => {
    setStats(index);
  };

  const handleAtributesValues = (attribute, value) => {
    setAttributeValue(attribute, value);
  };

  const handleAppearance = (type, value) => {
    setAppearanceValue(type, value);
  };

  const handleCombatMagic = (type, value) => {
    setCombatMagic(type, value);
  };

  const handleMoves = (value) => {
    setMovesList(value);
  };

  return (
    <main className="charCreation">
      <article className="charCreation__article">
        <Header
          title={header.title}
          subTitle={header.subTitle}
          placeholder={header.placeholder}
          initialValue={header.value}
          onChange={(t) => handleAtributesValues('header', t)}
        />
        <TextBlock
          title={charCreation.intro.title}
          description={charCreation.intro.description}
        />
        <AppearanceBox
          title={charCreation.appearance.title}
          sexList={charCreation.appearance.lists.sex}
          sexChange={(value) => handleAppearance('sex', value)}
          eyesList={charCreation.appearance.lists.eyes}
          eyesChange={(value) => handleAppearance('eyes', value)}
          clothesList={charCreation.appearance.lists.clothes}
          clothesChange={(value) => handleAppearance('clothes', value)}
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
      <article className="charCreation__article">
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
      <article className="charCreation__article">
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
