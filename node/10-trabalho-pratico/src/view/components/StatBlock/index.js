import React, { useState, useEffect } from 'react';
import './index.scss';

/**
 *
 * @param {Object} props
 * @param {Function} props.onChange
 * @param {Object[]} props.statsList
 * @param {String} props.statsList.title
 * @param {String} props.statsList.subTitle
 * @param {String} props.statsList.value
 */
const StatBlock = ({ statsList, onChange }) => {
  const handleChange = (value, index) => {
    if (onChange) onChange(value, index);
  };

  return (
    <section className="statBlock">
      <ul className="statBlock__list">
        {statsList.map((s, i) => (
          <StatItem
            key={s.title + i}
            title={s.title}
            subTitle={s.subTitle}
            value={s.value}
            onChange={(v) => handleChange(v, i)}
          />
        ))}
      </ul>
    </section>
  );
};

/**
 *
 * @param {Object} props
 * @param {String} props.title
 * @param {String[]} props.subTitle
 * @param {String} props.value
 * @param {Function} props.onChange
 */
const StatItem = ({ title, subTitle, value, onChange }) => {
  const [input, setInput] = useState(value);

  useEffect(() => {
    setInput(value);
  }, [value]);

  const handleChange = (e) => {
    setInput(Number(e.target.value));
    if (onChange) onChange(Number(e.target.value));
  };

  return (
    <li className="statItem">
      <label className="statItem__label">
        <div className="statItem__description">
          {subTitle.map((descriptionText) => (
            <p key={descriptionText}>{descriptionText}</p>
          ))}
        </div>
        <input
          className="statItem__input"
          value={input}
          onChange={handleChange}
          type="number"
        />
        <h3 className="statItem__title">{title}</h3>
      </label>
    </li>
  );
};

export default StatBlock;
