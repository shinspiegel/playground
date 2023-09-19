import React, { useState } from 'react';
import './index.css';

import { MdAddCircle } from 'react-icons/md';

/**
 * This input for new items on the list.
 * @param {Function} props.onClick This function will be called with the click on the button or with a keypress 'ENTER' with the value of the input.
 * @param {String=} props.placeholder This is the placeholder text to be showed.
 */
const ProductItem = ({ onClick, placeholder = '' }) => {
  const [input, setInput] = useState(name);

  const handleSubmit = (event) => {
    event.preventDefault();
    if (onClick) onClick(input);
    setInput('');
  };

  return (
    <li>
      <form className='productItemNew' onSubmit={handleSubmit}>
        <input value={input} onChange={(e) => setInput(e.target.value)} placeholder={placeholder} />
        <button type='submit' aria-label='adicionar produto'>
          <MdAddCircle />
        </button>
      </form>
    </li>
  );
};

export default ProductItem;
