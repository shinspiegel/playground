import React, { useState } from 'react';
import './index.css';

/**
 * This is a wrapper for the buttons on the bottom.
 */
const BottomMenu = ({ children }) => {
  const [toggle, setToggle] = useState(false);

  return (
    <div className={`bottomMenu ${toggle ? 'opened' : 'closed'}`}>
      <span onClick={() => setToggle(!toggle)}>
        <div />
        <div />
      </span>
      {children}
    </div>
  );
};

export default BottomMenu;
