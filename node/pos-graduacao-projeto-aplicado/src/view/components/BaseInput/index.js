import React from 'react';
import './index.css';

/**
 * This is the basic input that wraps a 'label', 'span' and a 'input'
 * @param {Object} props This is the props
 * @param {String=} props.label This is the text on the label
 * @param {String} props.value This is the value of the input
 * @param {String=} props.type This is the type of the input
 * @param {Object} props.onChange Everytime the input changes will trigger this function
 * @param {String=} props.placeholder This is the placeholder text
 */
const BaseInput = ({ label, type = 'text', placeholder = '', onChange, ...rest }) => {
  const onChangeHandler = (e) => {
    if (onChange) {
      return onChange(e.target.value);
    }
  };

  return (
    <label className='baseInput-label'>
      {label ? <span className='baseInput-span'>{label}</span> : null}
      <input
        className='baseInput-input'
        type={type}
        onChange={onChangeHandler}
        placeholder={placeholder}
        {...rest}
      />
    </label>
  );
};

export default BaseInput;
