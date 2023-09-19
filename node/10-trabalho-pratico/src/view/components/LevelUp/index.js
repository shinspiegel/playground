import React, { useState } from 'react';
import './index.scss';

import SubTitle from '../SubTitle';
import SmallTitle from '../SmallTitle';
import InputRange from '../InputRange';
import BoxText from '../BoxText';

/**
 *
 * @param {Object} props
 * @param {String=} props.title
 * @param {String=} props.smallTitle
 * @param {String[]=} props.descriptionList
 * @param {Number} props.initialValue
 * @param {Function} props.onChange
 *
 */
const LevelUp = ({
  title,
  smallTitle,
  descriptionList,
  initialValue,
  onChange,
  max = 5,
}) => {
  const [value, setValue] = useState(initialValue);

  const handleChange = (e) => {
    if (onChange) onChange(e.target.value);
    setValue(e.target.value);
  };

  return (
    <section className="levelUp">
      {title ? <SubTitle title={title} value={value} max={max} /> : null}
      {smallTitle ? (
        <SmallTitle title={smallTitle} value={value} max={max} />
      ) : null}{' '}
      <InputRange onChange={handleChange} value={value} />
      <BoxText text={descriptionList} />
    </section>
  );
};

export default LevelUp;
