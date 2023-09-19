import React from "react";
import { useRoute, useNavigation } from "@react-navigation/native";
import { StyleSheet, Text, View, FlatList, TouchableOpacity } from "react-native";
import useActions from "../context/useActions";
import config from "../config";
import { routesNames } from "../router";

const CompaniesTable = ({ productsList }) => {
  const { deleteProduct } = useActions();
  const { navigate } = useNavigation();

  const editHandler = (item) => {
    navigate(routesNames.productForm, { product: item });
  };

  const removeHandler = (itemID) => {
    deleteProduct(itemID);
  };

  return (
    <View style={styles.container}>
      <FlatList
        data={productsList}
        keyExtractor={(item) => item.id}
        renderItem={({ item }) => (
          <ProductRow item={item} edit={editHandler} remove={removeHandler} />
        )}
      />
    </View>
  );
};

const ProductRow = ({ item, edit, remove }) => (
  <View style={styles.row}>
    <View style={styles.productData}>
      <Text style={styles.productText}>{item.name}</Text>
    </View>

    <View style={styles.bottomWrapper}>
      <TouchableOpacity style={styles.buttonEdit} onPress={() => edit(item)}>
        <Text>Editar</Text>
      </TouchableOpacity>
      <TouchableOpacity style={styles.buttonDelete} onPress={() => remove(item._id)}>
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

  productData: {
    width: "75%",
    borderLeftColor: config.color.primary,
    borderLeftWidth: 3,
    paddingLeft: 6,
    justifyContent: "center",
  },

  productText: {
    color: config.color.primary,
    textTransform: "uppercase",
    letterSpacing: 1,
    fontSize: 16,
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
