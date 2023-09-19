import React, { useState } from 'react';
import './index.scss';

/**
 * This is the header function
 * @param {Object} props
 * @param {String} props.title
 * @param {String} props.subTitle
 * @param {String} props.placeholder
 * @param {String} props.initialValue
 * @param {Function} props.onChange
 */
const Header = ({ title, subTitle, placeholder, initialValue, onChange }) => {
  const [input, setInput] = useState(initialValue);

  const handleChange = (e) => {
    if (onChange) onChange(e.target.value);
    setInput(e.target.value);
  };

  return (
    <header className="header">
      <input
        className="header__input"
        value={input}
        onChange={handleChange}
        placeholder={placeholder}
        type="text"
      />
      <h1 className="header__title">{title}</h1>
      <small className="header__small">{subTitle}</small>
    </header>
  );
};

export default Header;
