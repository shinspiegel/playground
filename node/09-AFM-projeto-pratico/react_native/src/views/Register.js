import React, { useState, useEffect } from "react";
import { StyleSheet, Text, View } from "react-native";
import Icon from "react-native-vector-icons/MaterialIcons";
import config from "../config";
import useActions from "../context/useActions";
import { routesNames } from "../router";

import Input from "../components/Input";
import Button from "../components/Button";

const RegisterForm = (props) => {
  const { state, register } = useActions();
  const [form, setForm] = useState({ name: "", email: "", password: "" });

  const handleSubmit = () => {
    if (form.name && form.email && form.password) register(form);
    props.navigation.navigate(routesNames.login);
  };

  return (
    <View style={styles.container}>
      <Text style={styles.text}>Informe suas credências</Text>

      <Input
        label={"Nome"}
        onChange={(value) => setForm({ ...form, name: value })}
      />
      <Input
        label={"Email"}
        onChange={(value) => setForm({ ...form, email: value })}
      />
      <Input
        secureTextEntry={true}
        spellCheck={false}
        label={"Senha"}
        onChange={(value) => setForm({ ...form, password: value })}
      />
      <Button label="Registrar" onClick={handleSubmit} />
    </View>
  );
};

export const registerOptions = {
  headerTitle: "Registrar",
};

const styles = StyleSheet.create({
  container: {
    padding: 24,
    maxWidth: 500,
    flex: 1,
    backgroundColor: "#fff",
    alignItems: "center",
    justifyContent: "center",
  },

  text: {
    marginBottom: 24,
    color: config.color.accent,
  },
});

export default RegisterForm;
