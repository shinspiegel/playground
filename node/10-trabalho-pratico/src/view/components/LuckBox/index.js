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
 * @param {Number} props.initialValue
 * @param {Number=} props.min
 * @param {Number=} props.max
 * @param {Function} props.onChange
 */
const LuckBox = ({
  title,
  smallTitle,
  description,
  initialValue,
  onChange,
  min = 0,
  max = 6,
}) => {
  const [input, setInput] = useState(initialValue);

  const handleChange = (e) => {
    if (onChange) onChange(Number(e.target.value));
    setInput(Number(e.target.value));
  };

  const handleClick = (value) => {
    if (input + value > max || input + value < min) return;
    if (onChange) onChange(Number(input + value));
    setInput(Number(input + value));
  };

  return (
    <section className="luckBox">
      {title ? <SubTitle title={title} value={input} max={max} /> : null}
      {smallTitle ? (
        <SmallTitle title={smallTitle} value={input} max={max} />
      ) : null}
      <BoxText text={description} />
      <InputRange
        leftText="salvo"
        leftAction={() => handleClick(-1)}
        rightText="condenado"
        rightAction={() => handleClick(1)}
        max={6}
        value={input}
        onChange={handleChange}
      />
    </section>
  );
};

export default LuckBox;
