import React, { useState } from "react";
import { StyleSheet, TouchableOpacity, Text, View } from "react-native";
import Icon from "react-native-vector-icons/MaterialIcons";
import config from "../config";

const Button = ({ initialValue = "", onClick, label, ...rest }) => {
  const handleClick = () => {
    if (onClick) onClick();
  };

  return (
    <TouchableOpacity onPress={handleClick} style={styles.button} {...rest}>
      <Text style={styles.text}>{label}</Text>
    </TouchableOpacity>
  );
};

const styles = StyleSheet.create({
  button: {
    width: "100%",
    padding: 20,
    backgroundColor: config.color.primary,
    alignItems: "center",
    borderRadius: 6,
  },
  text: {
    textTransform: "uppercase",
    letterSpacing: 1,
    color: config.color.background,
  },
});

export default Button;
