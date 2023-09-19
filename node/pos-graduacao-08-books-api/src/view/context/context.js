import React, { useReducer, createContext } from 'react';
import Reducer from './reducer';
import InitialState from './initialState';

const AppContext = createContext(InitialState);

export const ContextProvider = ({ children }) => {
  const [state, dispatch] = useReducer(Reducer, InitialState);

  return <AppContext.Provider value={{ state, dispatch }}>{children}</AppContext.Provider>;
};

export default AppContext;
