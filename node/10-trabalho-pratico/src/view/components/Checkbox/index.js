import React from 'react';
import Markdown from 'react-markdown';
import './index.scss';

/**
 *
 * @param {Object} props.label
 * @param {String} props.name
 * @param {Boolean} props.isToggle
 * @param {Function} props.onCheck
 * @param {Function} props.onUncheck
 */
const CheckBox = ({ id, label, name, isToggle, onCheck, onUncheck }) => {
  const handleCheck = () => {
    if (isToggle) {
      if (onUncheck) onUncheck(`${id}{_}${label}`);
    } else {
      if (onCheck) onCheck(`${id}{_}${label}`);
    }
  };

  return (
    <label className="checkBox">
      <input
        className={`checkBox__input ${
          isToggle ? 'checkBox__input--checked' : ''
        }`}
        type="checkbox"
        name={name}
        checked={isToggle}
        onChange={handleCheck}
      />
      <span className="checkBox__mark" />
      <Markdown source={label} />
    </label>
  );
};

export default CheckBox;
