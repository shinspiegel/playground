import React, { useEffect } from 'react';
import { Switch, Route, Redirect, useLocation } from 'react-router-dom';
import { AnimatePresence, motion } from 'framer-motion';

import Private from './components/PrivateRoute';
import Public from './components/PublicRoute';
import { themeHandler, getBackgroundColor } from './utils';

import Login from './pages/Login';
import Register from './pages/Register';
import Recover from './pages/Recover';
import ResetPassword from './pages/ResetPassword';
import GroceryList from './pages/GroceryList';
import ProductSelect from './pages/ProductSelect';
import ProfilePage from './pages/Profile';

import ShowNotifications from './components/ShowNotification';
import Background from './components/Background';
import useActions from './context/useActions';

const Router = () => {
  const { pathname } = useLocation();
  const { state } = useActions();

  useEffect(() => {
    themeHandler(state.userTheme);
  }, []);

  return (
    <>
      <AnimatePresence>
        <Switch>
          <Route component={() => <Redirect to="/login" />} path="/" exact />
          <Route component={() => <h1>home</h1>} path="/home" />

          <Public component={Login} path="/login" />
          <Public component={Register} path="/register" />
          <Public component={Recover} path="/recover" exact />
          <Public component={ResetPassword} path="/recover/:id/:code" />

          <Private component={GroceryList} path="/list/:year/:week" />

          <Private component={ProductSelect} path="/product-select/:year/:week/:product_id" />

          <Private component={ProfilePage} path="/profile" />

          <Route component={() => <h1>404</h1>} path="/*" />
        </Switch>
      </AnimatePresence>

      <ShowNotifications />
      <Background color={getBackgroundColor(pathname)} />
    </>
  );
};

export default Router;
