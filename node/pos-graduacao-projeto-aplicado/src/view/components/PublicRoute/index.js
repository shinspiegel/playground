import React, { Component, useEffect } from 'react';
import useActions from '../../context/useActions';
import { Route, Redirect } from 'react-router-dom';
import { isLogged, getWeekNumber } from '../../utils';

/**
 * This is a public route, if the user is logged it will be redirect to another page.
 * @param {Object} props This is the props
 * @param {Component} props.component This is the props
 * @param {String=} props.redirect The path to redirect in case the user is not logged. Default if the current year and week list.
 */
const PrivateRoute = ({ component: Component, redirect, ...rest }) => {
  const year = new Date().getFullYear();
  const weekNumber = getWeekNumber();
  const { state } = useActions();

  let pathToRedirec = `list/${year}/${weekNumber}`;
  if (redirect) pathToRedirec = redirect;

  useEffect(() => {}, [state.userData]);

  return (
    <Route
      {...rest}
      render={(props) => (!isLogged() ? <Component {...props} /> : <Redirect to={pathToRedirec} />)}
    />
  );
};

export default PrivateRoute;
