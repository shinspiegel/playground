import React, { useState } from "react";
import { StyleSheet, Text, View, TextInput } from "react-native";
import config from "../config";

const Input = ({ initialValue = "", onChange, label, ...rest }) => {
  const [input, setInput] = useState(initialValue);

  const handleChange = (text) => {
    if (onChange) onChange(text);
    setInput(text);
  };

  return (
    <View style={styles.container}>
      <TextInput
        style={styles.input}
        value={input}
        onChangeText={handleChange}
        {...rest}
      />
      <Text style={styles.label}>{label}</Text>
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    flexDirection: "row",
  },

  label: {
    position: "absolute",
    top: -8,
    left: 8,
    paddingHorizontal: 4,
    backgroundColor: config.color.background,
    color: config.color.primary,
  },

  input: {
    flex: 1,
    backgroundColor: config.color.background,
    color: config.color.text,
    paddingHorizontal: 8,
    borderColor: config.color.primary,
    borderWidth: 1,
    borderRadius: 4,
    marginBottom: 24,
  },
});

export default Input;
