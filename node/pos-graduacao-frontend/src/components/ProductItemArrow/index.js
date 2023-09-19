import React from 'react';
import './index.css';
import { MdKeyboardArrowRight, MdKeyboardArrowDown } from 'react-icons/md';

/**
 * This componente will
 * @param {Boolean=} props.isOpened This the state of the opened arrow.
 * @param {Function=} props.onClick This is the handler function to handle the click event on this.
 */
const ProductItemArrow = ({ isOpened = false, onClick }) => {
  const handleClick = () => {
    if (onclick) onclick();
  };

  return (
    <>
      {isOpened ? (
        <span aria-label='comprimir'>
          <MdKeyboardArrowDown size={20} onClick={handleClick} />
        </span>
      ) : (
        <span aria-label='expandir'>
          <MdKeyboardArrowRight size={20} onClick={handleClick} />
        </span>
      )}
    </>
  );
};

export default ProductItemArrow;
