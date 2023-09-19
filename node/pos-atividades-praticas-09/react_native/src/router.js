import "react-native-gesture-handler";
import React, { useEffect } from "react";
import { StatusBar } from "expo-status-bar";
import { NavigationContainer } from "@react-navigation/native";
import { ContextProvider } from "./context/context";
import useActions from "./context/useActions";

import { createStackNavigator } from "@react-navigation/stack";
import { createBottomTabNavigator } from "@react-navigation/bottom-tabs";

import Home, { homeOptions } from "./views/Home";
import Login, { loginOption } from "./views/Login";
import CompanyForm, { companyFormOptions } from "./views/CompanyForm";

const Stack = createStackNavigator();
const Tab = createBottomTabNavigator();

const router = () => {
  const { state, checkUserStorage } = useActions();

  useEffect(() => {
    checkUserStorage();
  }, []);

  return (
    <NavigationContainer>
      <StatusBar style="auto" />

      <Stack.Navigator>
        {state.access.isLogged ? (
          <Stack.Screen
            name={routesNames.home}
            component={Home}
            options={homeOptions}
          />
        ) : (
          <Stack.Screen
            name={routesNames.login}
            component={Login}
            options={loginOption}
          />
        )}

        <Stack.Screen
          name={routesNames.companyForm}
          component={CompanyForm}
          options={companyFormOptions}
        />
      </Stack.Navigator>
    </NavigationContainer>
  );
};

export const routesNames = {
  home: "Home",
  login: "Login",
  companyForm: "CompanyForm",
};

export default router;
