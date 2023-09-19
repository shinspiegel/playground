import React from 'react';
import './index.css';

import { MdKeyboardArrowLeft, MdKeyboardArrowRight } from 'react-icons/md';

/**
 * This component will show the navigation.
 * @param {Object} props
 * @param {Number} props.weekNumber This is the week number to be displayed on the navigation.
 * @param {Number} props.price This is the total price to be showed.
 * @param {Function} props.onClickNext This function will be called on the right arrow.
 * @param {Function} props.onClickPrev This function will be called on the left arrow.
 */
const Navigation = ({ weekNumber, price = 0, onClickNext, onClickPrev }) => {
  if (!weekNumber) return null;

  const priceToSplit = Number(price).toFixed(2);
  const value = String(priceToSplit).split('.')[0];
  const cents = String(priceToSplit).split('.')[1];

  const handleClickNext = () => {
    if (onClickNext) onClickNext();
  };

  const handleClickPrev = () => {
    if (onClickPrev) onClickPrev();
  };

  return (
    <nav className='navigation'>
      <button onClick={handleClickPrev} aria-label='anterior' className='navigation-arrowLeft'>
        <MdKeyboardArrowLeft />
      </button>
      <button onClick={handleClickNext} aria-label='próximo' className='navigation-arrowRight'>
        <MdKeyboardArrowRight />
      </button>
      <div className='navigation-weekDisplay'>
        Lista da Semana:
        <strong className='bold'> {weekNumber}</strong>
      </div>
      <div className='navigation-priceDisplay'>
        <span className='money'>R$</span>
        <span className='value'>{value},</span>
        <span className='cents'>{cents}</span>
      </div>
    </nav>
  );
};

export default Navigation;
