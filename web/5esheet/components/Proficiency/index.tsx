import React from "react";
import cn from "./index.module.scss";

export interface ProficiencyBonusProps {
  proficiency: number;
  onProfChange: (prof: number) => void;
}

export const ProficiencyBonus: React.FC<ProficiencyBonusProps> = ({
  proficiency = 0,
  onProfChange = () => {},
}) => (
  <div className={cn.container}>
    <label>
      <span>Proficiency Bonus</span>
      <input
        type="number"
        value={proficiency}
        onChange={(e) => onProfChange(e.target.valueAsNumber)}
      />
    </label>
  </div>
);
