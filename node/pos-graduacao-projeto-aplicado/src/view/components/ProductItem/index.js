import React, { useState } from 'react';
import { motion } from 'framer-motion';
import './index.css';

import { MdSearch, MdShoppingBasket, MdRemoveCircleOutline } from 'react-icons/md';
import ProductItemPrice from '../ProductItemPrice';

/**
 * This is the component that will show a item for the user.
 * @param {Object} props This is the props
 * @param {Function} props.onBlur This function will trigger sendind a object with altered 'product' and the 'index' of the product.
 * @param {Function} props.searchIcon This function will be called when the clicked on the search icon.
 * @param {Function} props.toggleIcon This function will be called when the clicked on the toggle icon.
 * @param {Function} props.removeProdut This function will be called when the remove button is pressed.
 * @param {Object} props.product This is a product in the backend.
 */
const ProductItem = ({ product, onBlur, searchIcon, toggleIcon, productIndex, removeProdut }) => {
  if (!product) return null;

  const { productName: name, productReference: reference, _id, isBought } = product;
  const [input, setInput] = useState(name);

  const onBlurHandle = () => {
    if (input === '') {
      return setInput(name);
    }

    if (onBlur && input !== name) {
      const newProduct = { ...product, productName: input };
      onBlur({ product: newProduct, index: productIndex });
    }
  };

  const onClickSearchHandle = () => {
    if (searchIcon) searchIcon();
  };

  const onClickToggleBought = () => {
    if (toggleIcon) toggleIcon();
  };

  return (
    <motion.li
      initial={{ y: 10, scale: 0.5, opacity: 0 }}
      animate={{ y: 0, scale: 1, opacity: 1 }}
      exit={{ y: 10, scale: 1.1, opacity: 0 }}
      className={`productItem ${isBought ? 'strike' : ''}`}
    >
      <button onClick={onClickToggleBought}>
        <MdShoppingBasket />
      </button>
      <input onBlur={onBlurHandle} value={input} disabled={isBought} onChange={(e) => setInput(e.target.value)} />
      {reference && reference.price ? <ProductItemPrice price={reference.price} /> : null}
      <button onClick={onClickSearchHandle}>
        <MdSearch />
      </button>
      <button onClick={removeProdut}>
        <MdRemoveCircleOutline />
      </button>
    </motion.li>
  );
};

export default ProductItem;
