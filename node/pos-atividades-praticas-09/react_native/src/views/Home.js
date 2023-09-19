import React, { useEffect } from "react";
import { StyleSheet, View, TouchableOpacity, Text } from "react-native";
import useActions from "../context/useActions";
import CompaniesTable from "../components/CompaniesTable";
import { routesNames } from "../router";
import Button from "../components/Button";

const Home = (props) => {
  const { state, getCompanies, logout } = useActions();

  useEffect(() => {
    getCompanies();
  }, []);

  return (
    <View style={styles.container}>
      <CompaniesTable companiesList={state.companies} />
      <Button label="Deslogar" onPress={() => logout()} />
    </View>
  );
};

export const homeOptions = ({ navigation, route }) => ({
  headerTitle: "Lista de Empresas",
  headerRight: () => (
    <TouchableOpacity
      onPress={() => navigation.navigate(routesNames.companyForm)}
      style={styles.homeButton}
    >
      <Text>Adicionar</Text>
    </TouchableOpacity>
  ),
});

const styles = StyleSheet.create({
  container: {
    flex: 1,
    padding: 8,
    backgroundColor: "#fff",
    alignItems: "center",
    justifyContent: "flex-start",
  },

  homeButton: {
    marginRight: 8,
  },
});

export default Home;
