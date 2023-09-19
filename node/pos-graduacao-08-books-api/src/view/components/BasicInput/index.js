import React, { useState } from 'react';

const BasicInput = ({ label, type = 'text', placeholder, initialValue, onChange }) => {
  const [inputValue, setInputValue] = useState(initialValue);

  const handleChange = (e) => {
    setInputValue(e.target.value);
    if (onChange) onChange(e.target.value);
  };

  return (
    <label>
      <span>{label}</span>
      <input type={type} placeholder={placeholder || label} value={inputValue} onChange={handleChange} />
    </label>
  );
};

export default BasicInput;
