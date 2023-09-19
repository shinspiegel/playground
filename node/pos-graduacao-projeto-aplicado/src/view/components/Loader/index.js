import React from 'react';
import './index.css';

const Loader = ({ isLoading }) => {
  if (!isLoading) return null;

  return (
    <div className='loader'>
      <div></div>
      <div></div>
      <div></div>
      <div></div>
    </div>
  );
};

export default Loader;
