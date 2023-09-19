import React from "react";
import "react-native-gesture-handler";
import { registerRootComponent } from "expo";
import Router from "./src/router";
import { ContextProvider } from "./src/context/context";

const WrappedContext = () => (
  <ContextProvider>
    <Router />
  </ContextProvider>
);

registerRootComponent(WrappedContext);
