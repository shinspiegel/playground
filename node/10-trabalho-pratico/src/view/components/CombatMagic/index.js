import React from 'react';
import './index.scss';
import SubTitle from '../SubTitle';
import BoxText from '../BoxText';
import CombatMagicCheckbox from '../CombatMagicCheckbox';

/**
 *
 * @param {Object} props
 * @param {String} props.title
 * @param {String[]} props.descriptionList
 * @param {Object} props.base
 * @param {Function} props.baseChange
 * @param {Function} props.effectChange
 * @param {String} props.base.title
 * @param {String[]} props.base.options
 * @param {String[]} props.base.selected
 * @param {Object} props.effect
 * @param {String} props.effect.title
 * @param {String[]} props.effect.options
 * @param {String[]} props.effect.selected
 */
const CombatMagic = ({
  title,
  descriptionList,
  base,
  baseChange,
  effect,
  effectChange,
  min = 0,
  max = 3,
}) => {
  return (
    <section className="combatMagic">
      <SubTitle
        title={title}
        value={base.selected.length + effect.selected.length}
        max={max}
      />
      <BoxText text={descriptionList} />
      <CombatMagicCheckbox
        title={base.title}
        options={base.options}
        initialValues={base.selected}
        onChange={baseChange}
      />
      <CombatMagicCheckbox
        title={effect.title}
        options={effect.options}
        initialValues={effect.selected}
        onChange={effectChange}
      />
    </section>
  );
};

export default CombatMagic;
