import React, { useState } from 'react';
import './index.scss';
import SubTitle from '../SubTitle';
import RadioButton from '../RadioButton';
import BoxText from '../BoxText';

/**
 *
 * @param {Object} props
 * @param {String} props.title
 * @param {String} props.description
 * @param {String[]} props.options
 * @param {Function} props.onChange
 */
const RadioList = ({ title, options, description, onChange }) => {
  const [selected, setSelect] = useState(null);

  const handleChange = (value) => {
    setSelect(value);
    if (onChange) onChange(value);
  };

  return (
    <section className="radioList">
      <SubTitle title={title} />
      <BoxText text={description} />
      <ul className="radioList__list">
        {options.map((o, i) => (
          <li key={o + i}>
            <RadioButton
              label={o}
              name="baseStat"
              isChecked={selected === o}
              onChange={() => handleChange(o)}
            />
          </li>
        ))}
      </ul>
    </section>
  );
};

export default RadioList;
