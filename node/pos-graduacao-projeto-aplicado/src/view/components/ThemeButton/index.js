import React from 'react';
import './index.css';

/**
 * This is the theme button for selecting themes on profile
 * @param {Object} props This is the props
 * @param {String=} props.themeColor This is the hex color for the background circle
 * @param {Boolean=} props.isSelected This will trigger the selected effect.
 * @param {Function=} props.onClick This is the click event that will be triggered.
 */
const ThemeButton = ({ isSelected, onClick, themeColor }) => {
  const handleClick = () => {
    if (onClick) onClick();
  };

  const style = themeColor ? { '--background': themeColor } : {};

  return (
    <label style={style} className={`themeButton ${isSelected ? 'selected' : ''}`}>
      <input type="radio" name="themeButton" onClick={handleClick} checked={isSelected} />
      <span />
    </label>
  );
};

export default ThemeButton;
