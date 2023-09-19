import React, { useEffect, useState } from "react";
import { StyleSheet, ScrollView, TouchableOpacity, Text } from "react-native";
import useActions from "../context/useActions";
import Input from "../components/Input";
import Buttom from "../components/Button";
import { routesNames } from "../router";
import getInitial from "../utils/getInitialProduct";

const CompanyForm = ({ route, navigation }) => {
  const { updateProduct, createProduct } = useActions();
  const { initialProduct } = getInitial(route);

  const [form, setForm] = useState(initialProduct);

  const handleButton = () => {
    if (form._id) {
      updateProduct({ ...form });
    } else {
      createProduct({ ...form });
    }

    navigation.navigate(routesNames.home);
  };

  return (
    <ScrollView style={styles.container}>
      <Input
        label="Nome Fantasia"
        onChange={(value) => setForm({ ...form, name: value })}
        initialValue={form.name}
      />
      <Buttom label={form._id ? "Atualizar" : "Adicionar"} onClick={handleButton} />
    </ScrollView>
  );
};

export const productsFormOptions = {
  headerTitle: "Produto",
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    padding: 8,
    backgroundColor: "#fff",
  },
});

export default CompanyForm;
