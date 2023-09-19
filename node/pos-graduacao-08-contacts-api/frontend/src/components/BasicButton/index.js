import React from 'react';

const BasicButton = ({ label, type = 'submit' }) => {
  return <button type={type}>{label}</button>;
};

export default BasicButton;
