import React, { useEffect } from 'react';
import './index.css';

import useActions from '../../context/useActions';

/**
 * This componente will give the page a color background with a random unsplash image
 * @param {Object} props
 * @param {String=} props.color This is the hexcolor with the # or a color variable with the var() function. Default is the secondary color
 */
const Background = ({ color }) => {
  const { state, setBackgroundImage } = useActions();
  const { backgroundURL } = state;

  const width = window.innerWidth;
  const height = window.innerHeight;
  const url = 'https://source.unsplash.com';
  const query = 'supermarket,food';

  const backgroundColor = color ? { backgroundColor: color } : undefined;

  useEffect(() => {
    if (!backgroundURL) {
      fetch(`${url}/${width}x${height}/?${query}`)
        .then((res) => res.blob())
        .then((blob) => setBackgroundImage(blob));
    }
  }, []);

  return (
    <>
      <div className='backgroundImage-tint' style={backgroundColor} aria-hidden />
      <div
        className='backgroundImage-image'
        style={{ backgroundImage: `url(${backgroundURL})` }}
        aria-hidden
      />
    </>
  );
};

export default Background;
