import React, { useReducer, createContext } from 'react';
import Reducer from './reducer';
import InitialState from './initialState';

const AppContext = createContext(InitialState);

export const ContextProvider = ({ children, initialContext }) => {
  if (!initialContext) initialContext = InitialState;

  const [state, dispatch] = useReducer(Reducer, initialContext);

  return <AppContext.Provider value={{ state, dispatch }}>{children}</AppContext.Provider>;
};

export default AppContext;
