import React from 'react';
import './index.css';

/**
 * This is the base button component for form
 * @param {Object} props This is the props
 * @param {String=} props.className This is extra class names for this components
 * @param {String} props.label This is the label for the button
 * @param {Type=} props.type This is the type, as default it is 'submit'
 */
const BaseButton = ({ label, className = 'default', type = 'submit', ...rest }) => {
  return (
    <button className={`baseButton-button ${className}`} type={type} {...rest}>
      {label}
    </button>
  );
};

export default BaseButton;
