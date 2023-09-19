import React, { useReducer, createContext } from "react";
import Reducer from "./reducer";
import initialState from "./initialState";

const AppContext = createContext();

export const ContextProvider = ({ children }) => {
  const [state, dispatch] = useReducer(Reducer, initialState);

  return (
    <AppContext.Provider value={{ state, dispatch }}>
      {children}
    </AppContext.Provider>
  );
};

export default AppContext;
