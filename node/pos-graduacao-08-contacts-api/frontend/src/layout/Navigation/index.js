import React from 'react';
import './index.css';
import { Link } from 'react-router-dom';

const Navigation = () => {
  return (
    <nav>
      <h1>Agenda de Contatos</h1>
      <ul>
        <li>
          <Link to='/lista-de-contatos'>Listar contatos</Link>
        </li>
        <li>
          <Link to='/adicionar-contato'>Adicionar contato</Link>
        </li>
      </ul>
    </nav>
  );
};

export default Navigation;
