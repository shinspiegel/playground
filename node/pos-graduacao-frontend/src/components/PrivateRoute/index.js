import React, { Component, useEffect } from 'react';
import { Route, Redirect } from 'react-router-dom';
import { isLogged } from '../../utils';
import useActions from '../../context/useActions';

/**
 * This is the private route componente
 * @param {Object} props This is the props
 * @param {Component} props.component This is the props
 * @param {String=} props.redirect The path to redirect in case the user is not logged. Default is '/login'
 */
const PrivateRoute = ({ component: Component, redirect = '/login', ...rest }) => {
  const { setUser } = useActions();

  useEffect(() => {
    const userData = isLogged();
    if (userData) {
      setUser(userData);
    }
  }, []);

  return (
    <Route
      {...rest}
      render={(props) => (isLogged() ? <Component {...props} /> : <Redirect to={redirect} />)}
    />
  );
};

export default PrivateRoute;
