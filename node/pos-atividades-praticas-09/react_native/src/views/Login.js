import React, { useState, useEffect } from "react";
import { StyleSheet, Text, View } from "react-native";
import Icon from "react-native-vector-icons/MaterialIcons";
import config from "../config";
import useActions from "../context/useActions";

import Input from "../components/Input";
import Button from "../components/Button";

const LoginForm = (props) => {
  const { state, login, checkUserStorage } = useActions();
  const [form, setForm] = useState({ email: "", password: "" });

  const handleSubmit = () => {
    if (form.email && form.password) login(form);
  };

  useEffect(() => {
    checkUserStorage();
  }, []);

  return (
    <View style={styles.container}>
      <Icon name="supervisor-account" size={56} color={config.color.accent} />
      <Text style={styles.text}>Acesse com suas credenciais</Text>

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
      <Button label="Entrar" onClick={handleSubmit} />
    </View>
  );
};

export const loginOption = {
  headerTitle: "Entrar",
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

export default LoginForm;
