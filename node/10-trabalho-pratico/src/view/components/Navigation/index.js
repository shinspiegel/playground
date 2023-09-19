import React, { useState } from 'react';
import './index.scss';
import { Link } from 'react-router-dom';

const Navigation = () => {
  const [isOpen, setOpen] = useState(false);

  const handleToggle = () => {
    setOpen(!isOpen);
  };

  return (
    <>
      <nav className={`navigation ${isOpen ? 'navigation--opened' : ''}`}>
        <ul className="navigation__area">
          <NavLink label="Ficha Completa" link="/" />
          <NavLink label="Ficha Rápida" link="/ficha-rapida" />
          <NavLink label="Criação" link="/criacao-personagem" />
        </ul>
      </nav>
      <NavigationHamburger isOpen={isOpen} onClick={handleToggle} />
      <span className="navigation__overlay" onClick={handleToggle} />
    </>
  );
};

const NavigationHamburger = ({ isOpen, onClick }) => (
  <div
    className={`navigation__hamburguer ${
      isOpen ? 'navigation__hamburguer--opened' : ''
    }`}
    onClick={onClick}
  >
    <span className="navigation__hamburguerLine navigation__hamburguerLine--one" />
    <span className="navigation__hamburguerLine navigation__hamburguerLine--two" />
    <span className="navigation__hamburguerLine navigation__hamburguerLine--three" />
  </div>
);

const NavLink = ({ label, link }) => (
  <li className="navigation__link">
    <Link to={link}>{label}</Link>
  </li>
);

export default Navigation;
