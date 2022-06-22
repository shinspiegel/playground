import React, { useState } from "react";
import { Proficiency, Stat } from "../../stores";
import cn from "./index.module.scss";

export interface ProficiencyItemProps {
  proficiency: ProficiencyWithValue;
  onRemove: () => void;
}

type ProficiencyWithValue = Proficiency & { value: number };

export const ProficiencyItem: React.FC<ProficiencyItemProps> = ({
  proficiency = {} as ProficiencyWithValue,
  onRemove = () => {},
}) => {
  return (
    <div className={cn.container}>
      <span>{proficiency.name}</span>
      {proficiency.value ? (
        <span>
          {" "}
          - {proficiency.value} [{proficiency.short}]
        </span>
      ) : (
        ""
      )}
      <button type="button" onClick={onRemove}>
        X
      </button>
    </div>
  );
};
