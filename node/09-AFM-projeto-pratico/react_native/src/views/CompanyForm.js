import React, { useEffect, useState } from "react";
import { StyleSheet, ScrollView, TouchableOpacity, Text } from "react-native";
import useActions from "../context/useActions";
import CompaniesTable from "../components/CompaniesTable";
import Input from "../components/Input";
import Buttom from "../components/Button";
import { routesNames } from "../router";
import getInitial from "../utils/getInitialCompany";

const CompanyForm = ({ route, navigation }) => {
  const { updateCompany, createCompany } = useActions();
  const { initialCompany, initialAddress } = getInitial(route);

  const [form, setForm] = useState(initialCompany);
  const [address, setAddress] = useState(initialAddress);

  const handleButton = () => {
    if (form._id) {
      updateCompany({ ...form, address: address });
    } else {
      createCompany({ ...form, address: address });
    }

    navigation.navigate(routesNames.home);
  };

  return (
    <ScrollView style={styles.container}>
      <Input
        label="Nome Fantasia"
        onChange={(value) => setForm({ ...form, companyName: value })}
        initialValue={form.companyName}
      />
      <Input
        label="Razão Social"
        onChange={(value) => setForm({ ...form, corporateName: value })}
        initialValue={form.corporateName}
      />
      <Input
        label="CNPJ"
        onChange={(value) => setForm({ ...form, corporateCode: value })}
        initialValue={form.corporateCode}
      />
      <Input
        label="Cidade"
        onChange={(value) => setAddress({ ...address, city: value })}
        initialValue={address.city}
      />
      <Input
        label="Bairro"
        onChange={(value) => setAddress({ ...address, neighborhood: value })}
        initialValue={address.neighborhood}
      />
      <Input
        label="Endereço"
        onChange={(value) => setAddress({ ...address, street: value })}
        initialValue={address.street}
      />
      <Input
        label="Numero"
        onChange={(value) => setAddress({ ...address, number: value })}
        initialValue={address.number}
      />
      <Buttom
        label={form._id ? "Atualizar" : "Adicionar"}
        onClick={handleButton}
      />
    </ScrollView>
  );
};

export const companyFormOptions = {
  headerTitle: "Empresa",
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    padding: 8,
    backgroundColor: "#fff",
  },
});

export default CompanyForm;
