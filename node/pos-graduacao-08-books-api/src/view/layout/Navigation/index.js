import React from 'react';
import './index.css';
import { Link } from 'react-router-dom';

const Navigation = () => {
  return (
    <nav>
      <h1>Cadastro de Livros</h1>
      <ul>
        <li>
          <Link to="/lista-de-livros">Lista de Livros</Link>
        </li>
        <li>
          <Link to="/adicionar-livro">Adicionar Livros</Link>
        </li>
      </ul>
    </nav>
  );
};

export default Navigation;
