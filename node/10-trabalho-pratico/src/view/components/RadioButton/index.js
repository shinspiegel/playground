import React from 'react';
import './index.scss';

/**
 *
 * @param {Object} props
 * @param {String} props.label
 * @param {String} props.name
 * @param {Boolean} props.isChecked
 * @param {Function} props.onChange
 */
const RadioButton = ({ label, name, isChecked, onChange }) => (
  <label className="radioButton">
    <input
      className={`radioButton__input ${
        isChecked ? 'radioButton__input--checked' : ''
      }`}
      type="radio"
      name={name}
      checked={isChecked}
      onChange={() => onChange(label)}
    />
    <span className="radioButton__mark" />
    {label}
  </label>
);

export default RadioButton;
