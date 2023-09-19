import React from 'react';
import LogoImageBranco from '../../assets/logo_branco.png';
import LogoImageColor from '../../assets/logo_color.png';
import './index.css';

/**
 * This is the logo component to show the app logo.
 * @param {Object} props This is the component props
 * @param {Number=} props.size This is the size of the in number that will be converte to rem. Default is 20.
 * @param {Boolean=} props.white The modifier to show the logo in white. By default it's false
 */
const Logo = ({ size = 15, white = false }) => {
  const selectedImage = white ? LogoImageBranco : LogoImageColor;

  return (
    <img
      className='imageLogo'
      src={selectedImage}
      alt='MeuMercado - Suas compras facilitadas'
      style={{ '--logoSize': `${size}rem` }}
    />
  );
};

export default Logo;
