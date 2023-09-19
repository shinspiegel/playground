import React from 'react';
import './index.css';

/**
 * This componente is a wrapper for the shopping list items.
 * @param {Object} props This is the props
 */
const ProductsList = ({ children }) => {
  if (children) {
    return <ul className='productList'>{children}</ul>;
  }

  return null;
};

export default ProductsList;
