import React from "react";
import { infoSlice, useAppDispatch, useAppSelector } from "../../stores";
import cn from "./index.module.scss";

export const ProficiencyBonus: React.FC = () => {
  const dispatch = useAppDispatch();
  const profBonus = useAppSelector((s) => s.info.proficiency);
  const { setProficiency } = infoSlice.actions;

  return (
    <div className={cn.container}>
      <label>
        <span>Proficiency Bonus</span>
        <input
          type="number"
          value={profBonus}
          onChange={(e) => dispatch(setProficiency(e.target.valueAsNumber))}
        />
      </label>
    </div>
  );
};
