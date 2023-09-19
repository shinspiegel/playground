import React, { useState } from 'react';
import './index.css';

/**
 * This is the product select name.
 * This component will only trigger onChange method after a waitTimer.
 * @param {Object} props
 * @param {String} props.initialValue This is the value of the input.
 * @param {Function} props.onChange This function will be called on every change, passing the value as argument.
 * @param {Number} props.waitTimer This is the delayed time until the onChange function.
 */
const ProductSelectName = ({ initialValue, onChange }) => {
  const [value, setValue] = useState(initialValue);

  const onChangeHandler = (e) => {
    setValue(e.target.value);
  };

  const onBlurHandler = () => {
    if (value === '') {
      setValue(initialValue);
      return;
    }

    if (onChange) {
      onChange(value);
      return;
    }
  };

  return (
    <label className='productSelectName'>
      <input value={value} onChange={onChangeHandler} aria-label={value} onBlur={onBlurHandler} />
    </label>
  );
};

export default ProductSelectName;
