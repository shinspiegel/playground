import React from 'react';
import { BrowserRouter, Switch, Route, Redirect } from 'react-router-dom';

import Navigation from './layout/Navigation';
import ContactList from './pages/ContactList';
import AddContact from './pages/AddContact';
import EditContact from './pages/EditContact';

const Router = () => {
  return (
    <BrowserRouter>
      <Navigation />

      <Switch>
        <Route path='/' exact component={() => <Redirect to='/lista-de-contatos' />} />
        <Route component={ContactList} path='/lista-de-contatos' />
        <Route component={EditContact} path='/editar-contato/:id' />
        <Route component={AddContact} path='/adicionar-contato' />
        <Route component={() => <h1>404</h1>} path='/*' />
      </Switch>
    </BrowserRouter>
  );
};

export default Router;
