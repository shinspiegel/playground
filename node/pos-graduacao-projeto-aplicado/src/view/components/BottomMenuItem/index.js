import React from 'react';
import { MdSettings } from 'react-icons/md';
import './index.css';

/**
 *
 * @param {object} props
 * @param {object} props.icon This is the icon component to be rendered
 * @param {object} props.label This is the label text for this button
 * @param {object} props.onClick This is the function that will be triggered when clicked on this button
 */
const BottomMenu = ({ icon: IconComponent, label, onClick }) => {
  return (
    <button className='bottomMenuItem' onClick={onClick}>
      <span>
        <IconComponent />
      </span>
      <label>{label}</label>
    </button>
  );
};

export default BottomMenu;
