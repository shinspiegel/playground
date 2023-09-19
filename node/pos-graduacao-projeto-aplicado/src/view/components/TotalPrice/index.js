import React from 'react';
import './index.css';

/**
 * This component receives displays the total price with styled effect.
 * @param {Object} props This is the props
 * @param {Number} props.price This is the value in number to display.
 */
const TotalPrice = ({ price }) => {
  if (price) {
    const value = String(price).split('.')[0];
    const cents = String(price).split('.')[1];

    return (
      <div className='totalPrice'>
        <span className='totalPrice-money'>R$</span>
        <span className='totalPrice-value'>{value},</span>
        <span className='totalPrice-cents'>{cents}</span>
      </div>
    );
  }

  return null;
};

export default TotalPrice;
