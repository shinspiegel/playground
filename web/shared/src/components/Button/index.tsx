import React from "react";
import "./index.scss";

export interface ButtonProps extends React.PropsWithChildren {
  label: string;
}

export function Button({ label }: ButtonProps) {
  return <button type="button">{label}</button>;
}
