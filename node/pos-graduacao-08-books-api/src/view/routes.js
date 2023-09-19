import React from 'react';
import { BrowserRouter, Switch, Route, Redirect } from 'react-router-dom';

import Navigation from './layout/Navigation';
import BookList from './pages/BookList';
import AddBook from './pages/AddBook';
import EditBook from './pages/EditBook';

const Router = () => {
  return (
    <BrowserRouter>
      <Navigation />

      <Switch>
        <Route path="/" exact component={() => <Redirect to="/lista-de-livros" />} />
        <Route component={BookList} path="/lista-de-livros" />
        <Route component={EditBook} path="/editar-livro/:id" />
        <Route component={AddBook} path="/adicionar-livro" />
        <Route component={() => <h1>404</h1>} path="/*" />
      </Switch>
    </BrowserRouter>
  );
};

export default Router;
