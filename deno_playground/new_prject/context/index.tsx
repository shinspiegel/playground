import React, { useReducer, createContext, ReactNode } from "react";
import Reducer from "./reducer.ts";
import InitialState, { iState } from "./initialState.ts";

export interface iDispatch {
    type: string;
    payload: any;
}

export interface iContextType {
    state: iState;
    dispatch: iDispach;
}

interface ContextProps {
    children: ReactNode;
    initialState: iState;
}

export const AppContext = createContext(InitialState);

export const ContextProvider = ({ children, initialState }: ContextProps) => {
    if (!initialState) initialState = InitialState;

    const [state, dispatch] = useReducer(Reducer, initialState);

    return (
        <AppContext.Provider value={{ state, dispatch }}>
            {children}
        </AppContext.Provider>
    );
};
