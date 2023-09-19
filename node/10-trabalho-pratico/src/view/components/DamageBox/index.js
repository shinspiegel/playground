import React, { useState } from 'react';
import './index.scss';

import SubTitle from '../SubTitle';
import SmallTitle from '../SmallTitle';
import BoxText from '../BoxText';
import InputRange from '../InputRange';

/**
 *
 * @param {Object} props
 * @param {String=} props.title
 * @param {String=} props.smallTitle
 * @param {String=} props.description
 * @param {Number} props.healthValue
 * @param {Function} props.healthChange
 * @param {Number=} props.min
 * @param {Number=} props.max
 */
const DamageBox = ({
  title,
  smallTitle,
  description,
  healthValue,
  healthChange,
  min = 0,
  max = 7,
}) => {
  const [health, setHealth] = useState(healthValue);

  const handleChange = (e) => {
    if (healthChange) healthChange(Number(e.target.value));
    setHealth(Number(e.target.value));
  };

  const handleClick = (value) => {
    if (health + value > max || health + value < min) return;
    if (healthChange) healthChange(Number(health + value));
    setHealth(Number(health + value));
  };

  return (
    <section className="damageBox">
      {title ? <SubTitle title={title} /> : null}
      {smallTitle ? <SmallTitle title={smallTitle} /> : null}
      <BoxText text={description} />
      <InputRange
        leftText="Ileso"
        leftAction={() => handleClick(-1)}
        rightText="Morrendo"
        rightAction={() => handleClick(1)}
        max={6}
        value={health}
        onChange={handleChange}
      />
      {health >= 4 ? (
        <>
          <p className="damageBox__instableText">Instável</p>
          <small className="damageBox__instableDescription">
            (Lesões instáveis pioram com o tempo)
          </small>
        </>
      ) : null}
    </section>
  );
};

export default DamageBox;
