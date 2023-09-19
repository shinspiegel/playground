import React, { useState } from 'react';
import './index.scss';
import useActions from '../../context/useActions';

import Header from '../../components/Header';
import LuckBox from '../../components/LuckBox';
import DamageBox from '../../components/DamageBox';
import ListItem from '../../components/ListItem';
import LevelUp from '../../components/LevelUp';
import QuickStats from '../../components/QuickStats';
import SubTitle from '../../components/SubTitle';

const Home = () => {
  const { state, setAttributeValue } = useActions();
  const {
    header,
    stats,
    luckBox,
    damageBox,
    levelUp,
    combatMagic,
    moves,
    equips,
  } = state;

  const handleAtributesValues = (attribute, value) => {
    setAttributeValue(attribute, value);
  };

  return (
    <main className="quickSheet">
      <article className="quickSheet__article">
        <Header
          title={header.title}
          subTitle={header.subTitle}
          placeholder={header.placeholder}
          initialValue={header.value}
          onChange={(v) => handleAtributesValues('header', v)}
        />
        <QuickStats statsList={stats} />
        <LuckBox
          smallTitle={luckBox.title}
          initialValue={luckBox.value}
          onChange={(v) => handleAtributesValues('luckBox', v)}
        />
        <DamageBox
          smallTitle={damageBox.title}
          healthValue={damageBox.value}
          healthChange={(v) => handleAtributesValues('damageBox', v)}
        />
        <LevelUp
          smallTitle={levelUp.title}
          label={levelUp.label}
          initialValue={levelUp.value}
          onChange={(v) => handleAtributesValues('levelUp', v)}
        />
      </article>
      <article className="quickSheet__article">
        <SubTitle title={combatMagic.title} />
        <ListItem
          smallTitle={combatMagic.base.title}
          options={combatMagic.base.selected.map((i) => i.split('{_}')[1])}
        />
        <ListItem
          smallTitle={combatMagic.effect.title}
          options={combatMagic.effect.selected.map((i) => i.split('{_}')[1])}
        />
        <ListItem title={equips.title} options={[equips.value]} />
      </article>
      <article className="quickSheet__article">
        <SubTitle title={moves.title} />
        <ListItem
          smallTitle={moves.title}
          options={[
            ...moves.default,
            ...moves.movesListSelected.map((i) => i.split('{_}')[1]),
          ]}
        />
      </article>
    </main>
  );
};

export default Home;
