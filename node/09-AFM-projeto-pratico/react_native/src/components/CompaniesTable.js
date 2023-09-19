import React from "react";
import { useRoute, useNavigation } from "@react-navigation/native";
import {
  StyleSheet,
  Text,
  View,
  FlatList,
  TouchableOpacity,
} from "react-native";
import useActions from "../context/useActions";
import config from "../config";
import { routesNames } from "../router";

const CompaniesTable = ({ companiesList }) => {
  const { deleteCompary } = useActions();
  const { navigate } = useNavigation();

  const editHandler = (item) => {
    navigate(routesNames.companyForm, { company: item });
  };

  const removeHandler = (itemID) => {
    deleteCompary(itemID);
  };

  return (
    <View style={styles.container}>
      <FlatList
        data={companiesList}
        keyExtractor={(item) => item.id}
        renderItem={({ item }) => (
          <CompanyRow item={item} edit={editHandler} remove={removeHandler} />
        )}
      />
    </View>
  );
};

const CompanyRow = ({ item, edit, remove }) => (
  <View style={styles.row}>
    <View style={styles.companyData}>
      <Text style={styles.companyText}>{item.companyName}</Text>
      <Text style={styles.corporateText}>{item.corporateName}</Text>
      <Text style={styles.corporateCode}>CNPJ: {item.corporateCode}</Text>
    </View>

    <View style={styles.bottomWrapper}>
      <TouchableOpacity style={styles.buttonEdit} onPress={() => edit(item)}>
        <Text>Editar</Text>
      </TouchableOpacity>
      <TouchableOpacity
        style={styles.buttonDelete}
        onPress={() => remove(item._id)}
      >
        <Text>Apagar</Text>
      </TouchableOpacity>
    </View>
  </View>
);

const styles = StyleSheet.create({
  container: {
    flex: 1,
  },

  row: {
    flexDirection: "row",
    width: "100%",
    marginBottom: 8,
  },

  companyData: {
    width: "75%",
    borderLeftColor: config.color.primary,
    borderLeftWidth: 3,
    paddingLeft: 6,
  },

  companyText: {
    color: config.color.primary,
    textTransform: "uppercase",
    letterSpacing: 1,
    fontSize: 16,
  },

  corporateText: {
    fontSize: 14,
  },

  corporateCode: {
    fontSize: 10,
    fontWeight: "bold",
  },

  bottomWrapper: {
    width: "25%",
    justifyContent: "center",
    alignItems: "center",
    paddingHorizontal: 8,
  },

  buttonEdit: {
    padding: 4,
    width: "100%",
    justifyContent: "center",
    alignItems: "center",
    marginBottom: 4,
    borderColor: config.color.primary,
    color: config.color.primary,
    borderWidth: 1,
    borderRadius: 4,
  },

  buttonDelete: {
    padding: 4,
    width: "100%",
    justifyContent: "center",
    alignItems: "center",
    borderColor: config.color.warning,
    color: config.color.warning,
    borderWidth: 1,
    borderRadius: 4,
  },
});

export default CompaniesTable;
