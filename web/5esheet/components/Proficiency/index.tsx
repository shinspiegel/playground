import React from "react";
import { UseProficiencyBonus } from "../../hooks/useProficiencyBonus";
import { infoSlice, useAppDispatch, useAppSelector } from "../../stores";
import cn from "./index.module.scss";

export interface ProficiencyBonusProps {
  bonus: number;
  onChange: (e: React.ChangeEvent<HTMLInputElement>) => void;
}

export const ProficiencyBonus: React.FC<ProficiencyBonusProps> = ({ bonus = 0, onChange = () => {} }) => (
  <div className={cn.container}>
    <label>
      <span>Proficiency Bonus</span>
      <input type="number" value={bonus} onChange={onChange} />
    </label>
  </div>
);
