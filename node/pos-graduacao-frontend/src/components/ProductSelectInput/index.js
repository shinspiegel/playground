import React from 'react';
import './index.css';

import { MdRadioButtonChecked, MdRadioButtonUnchecked } from 'react-icons/md';
import ProductItemPrice from '../ProductItemPrice';

/**
 * This is a radio select to be used on the product selet page
 * @param {Object} props
 * @param {String} props.radioName This is the radio group name
 * @param {String} props.label This is the name to be displayed on the label
 * @param {Strign} props.value This is the value of the input. Usually is the id
 * @param {Boolean} props.isChecked The input is checked?
 * @param {Function} props.onChange This function will be trigger every time the value is changed, passing the value as argument
 * @param {String|Number} props.price This is the price product
 */
const ProductSelectInput = ({ radioName, label, value, isChecked, onChange, price }) => {
  const onChangeHandler = (e) => {
    if (onChange) onChange(e.target.value);
  };

  return (
    <li>
      <label className='productSelectInput'>
        <input
          type='radio'
          onChange={onChangeHandler}
          checked={isChecked}
          name={radioName}
          value={value}
          style={{ position: 'absolute', opacity: 0, cursor: 'pointer', height: 0, width: 0 }}
        />

        <span className='productSelectInput-checkedmark'>
          {isChecked ? <MdRadioButtonChecked /> : <MdRadioButtonUnchecked />}
        </span>
        <span>{label}</span>
        <ProductItemPrice price={price} />
      </label>
    </li>
  );
};

export default ProductSelectInput;
