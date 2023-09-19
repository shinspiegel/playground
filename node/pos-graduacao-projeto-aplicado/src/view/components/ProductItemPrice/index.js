import React from 'react';
import './index.css';

/**
 * This compoente receives a number and shows as a price value on the product list.
 * @param {Object} props This is the props
 * @param {Number} props.price This is the price value to be showed
 */
const ProductItemPrice = ({ price }) => {
  const value = String(price).split('.')[0];
  const cents = String(price).split('.')[1];

  if (price) {
    return (
      <div className='productItemPrice'>
        <span className='productItemPrice-money'>R$</span>
        <span className='productItemPrice-value'>{value},</span>
        <span className='productItemPrice-cents'>{cents}</span>
      </div>
    );
  }

  return null;
};

export default ProductItemPrice;
