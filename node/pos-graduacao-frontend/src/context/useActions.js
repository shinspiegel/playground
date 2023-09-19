import { useContext } from 'react';
import AppContext from './context';
import { reducerCases as redux } from './reducer';
import { setCookie, fetchArgs, notificationList, removeCookie } from '../utils';
import { useHistory } from 'react-router-dom';

const backendURL = process.env.BACKEND;
const frontendURL = process.env.FRONTEND;

const useActions = () => {
  const { state, dispatch } = useContext(AppContext);

  /**
   * This is a function to make a login call on the backend
   * @param {Object} loginForm This is the form Object.
   * @param {String} loginForm.email The user email to check on the backend.
   * @param {String} loginForm.password The password to check on the backend.
   */
  const login = async (loginForm) => {
    if (!loginForm.email) return addNotification('FRONT_EMAIL_01');
    if (!loginForm.password) return addNotification('FRONT_PASSWORD_01');

    const args = fetchArgs({ type: 'POST', body: loginForm });
    const response = await fetch(`${backendURL}/login`, args).then((res) => res.json());

    if (response.error) return addNotification(response.error);

    setCookie('user', response);
    dispatch({ type: redux.setUser, payload: response });
  };

  /**
   * This function will logout the user from the applications
   */
  const logout = async () => {
    removeCookie('user');
    dispatch({ type: redux.cleanState });
    addNotification('LOGOUT_SUCESS_01');
  };

  /**
   * This function will return a new user from the backend
   * @param {Object} registerForm This is the form Object.
   * @param {String} registerForm.name The user name to check on the backend.
   * @param {String} registerForm.email The user email to check on the backend.
   * @param {String} registerForm.password The password to check on the backend.
   */
  const register = async (registerForm) => {
    if (!registerForm.email) return addNotification('FRONT_EMAIL_01');
    if (!registerForm.password) return addNotification('FRONT_PASSWORD_01');

    const args = fetchArgs({ type: 'POST', body: registerForm });
    const response = await fetch(`${backendURL}/users`, args).then((res) => res.json());

    if (response.error) return addNotification(response.error);

    setCookie('user', response);
    setUser(response);
  };

  /**
   * This function will trigger a mail to recover
   * @param {Object} registerForm This is the form Object.
   * @param {String} registerForm.email The user email to check on the backend.
   */
  const recover = async (registerForm) => {
    if (!registerForm.email) return addNotification('FRONT_EMAIL_01');

    const response = await fetch(`${backendURL}/recover?email${registerForm.email}`);

    return addNotification('RECOVER_01');
  };

  /**
   * This function will trigger a mail to recover
   * @param {Object} registerForm This is the form Object.
   * @param {String} registerForm.id The user ID, this should be automatic page the page URL.
   * @param {String} registerForm.code The user recover code,
   * @param {String} registerForm.email The user email to check on the backend.
   */
  const resetPassword = async (registerForm) => {
    if (!registerForm.password) return addNotification('FRONT_PASSWORD_01');

    const args = fetchArgs({ type: 'POST', body: registerForm });

    return await fetch(`${backendURL}/recover`, args)
      .then(() => {
        addNotification('PASSWORD_UPDATE_01');
        return true;
      })
      .catch((err) => {
        console.log(err);
        return false;
      });
  };

  /**
   * This function will update the user on the backend and on the state
   * @param {Object} userForm This is the complete user data on the state
   * @returns {Boolean} Will return true if correctly updated
   */
  const updateUser = async (userForm) => {
    const { _id: id, name, email, password } = userForm;

    if (!name) {
      addNotification('FRONT_NAME_01');
      return false;
    }
    if (!email) {
      addNotification('FRONT_EMAIL_01');
      return false;
    }
    if (!password) {
      addNotification('FRONT_PASSWORD_01');
      return false;
    }

    const args = fetchArgs({ type: 'PUT', auth: true, body: { name, email, password } });
    const url = `${backendURL}/users/${id}`;
    const response = await fetch(url, args)
      .then((res) => res.json())
      .catch((err) => console.log(err));

    addNotification('USER_UPDATE_01');
    setUser(response);

    return true;
  };

  const setBackgroundImage = (imageBlob) => {
    const blob = imageBlob;
    const url = URL.createObjectURL(imageBlob);

    dispatch({ type: redux.setBackgroundImage, payload: { blob, url } });
  };

  /**
   * This function will add the selected year and week list to the grocery list state.
   * @param {Object} config This is the config object
   * @param {Number} config.year The year to call
   * @param {Number} config.week The week to call
   */
  const getList = async ({ year, week }) => {
    dispatch({ type: redux.setLoader, payload: true });

    if (!year || !week) {
      return console.error('useAction.getList: Year or Week absent in the function call');
    }

    const args = fetchArgs({ type: 'GET', auth: true });
    const url = `${backendURL}/grocery-lists/${year}/${week}`;
    const response = await fetch(url, args).then((res) => res.json());

    dispatch({ type: redux.addList, payload: response });
    dispatch({ type: redux.setLoader, payload: false });
  };

  /**
   * This action will change the groceryList, and will trigger a optministic update on the backend
   * @param {Object} config This is the config object.
   * @param {Object[]} config.updateList This is the array of produtcs.
   * @param {String} config.listId This is the ID for the groceryList.
   * @param {String} config.year The year to change.
   * @param {String} config.week The week to change.
   */
  const updateList = async ({ updatedList, listId, year, week }) => {
    dispatch({ type: redux.updateList, payload: { updatedList, listId } });

    const args = fetchArgs({ type: 'POST', auth: true, body: { productsList: updatedList } });
    const url = `${backendURL}/grocery-lists/${year}/${week}`;
    const fetchedList = await fetch(url, args).then((res) => res.json());

    dispatch({
      type: redux.updateList,
      payload: { updatedList: fetchedList.productsList, listId: fetchedList._id },
    });
  };

  /**
   * This function will get the products from the last week and include on this week list
   * @param {number} year The currente year
   * @param {number} week The current week
   */
  const getFromLastWeek = async (year, week) => {
    const args = fetchArgs({ type: 'POST', auth: true });
    const url = `${backendURL}/get-from-last/${year}/${week}`;
    const newList = await fetch(url, args).then((res) => res.json());

    dispatch({
      type: redux.updateList,
      payload: { updatedList: newList.productsList, listId: newList._id },
    });
  };

  /**
   * This function will set the user information on the state of the application
   * @param {Object} userData This is the user data to set on the state.
   */
  const setUser = (userData) => {
    dispatch({ type: redux.setUser, payload: userData });
  };

  /**
   * This function will return an array of products by it's given query string
   * @param {String} productName This is the product name to be used in the query string
   * @returns {Object[]} It will return a array of product objects
   */
  const getProductsByName = async (productName) => {
    const encodedString = encodeURIComponent(productName);
    const args = fetchArgs({ auth: true });
    const url = `${backendURL}/products?search=${encodedString}`;

    return await fetch(url, args)
      .then((res) => res.json())
      .catch(console.log);
  };

  /**
   * This function removes a notification by it's given ID.
   * @param {String} notificationId This is the notification ID to be filtered on the notification's state.
   */
  const removeNotification = async (notificationId) => {
    const newNotificationsList = state.notification.filter((n) => n.id !== notificationId);

    return dispatch({
      type: redux.setNotification,
      payload: newNotificationsList,
    });
  };

  /**
   * This function will add at the end of the notification array a new notification object.
   * @param {String} notificationId This is the notification ID to be filtered on the notification's state.
   */
  const addNotification = async (notificationId) => {
    const alreadyExist = state.notification.find((n) => n.id === notificationId);
    if (alreadyExist) return;

    let newNotification = notificationList.find((n) => n.id === notificationId);

    if (!newNotification) {
      newNotification = notificationList.find((n) => n.id === '00');
    }

    const newNotificationsList = [...state.notification, newNotification];

    return dispatch({
      type: redux.setNotification,
      payload: newNotificationsList,
    });
  };

  return {
    state,

    login,
    logout,
    register,
    recover,
    resetPassword,

    getList,
    updateList,
    getFromLastWeek,

    setUser,
    updateUser,

    setBackgroundImage,

    getProductsByName,

    removeNotification,
    addNotification,
  };
};

export default useActions;
