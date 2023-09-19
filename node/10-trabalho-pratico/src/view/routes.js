import React from 'react';
import { BrowserRouter, Switch, Route, Redirect } from 'react-router-dom';
import Navigation from './components/Navigation';

import Home from './pages/Home';
import CharCreation from './pages/CharCreation';
import Moves from './pages/Moves';
import QuickSheet from './pages/QuickSheet';

const Router = () => {
  return (
    <BrowserRouter>
      <Navigation />
      <Switch>
        <Route component={Home} path="/" exact />
        <Route component={QuickSheet} path="/ficha-rapida" />
        <Route component={CharCreation} path="/criacao-personagem" />
        <Route component={() => <h1>404</h1>} path="/*" />
      </Switch>
    </BrowserRouter>
  );
};

export default Router;
