import React, { HTMLInputTypeAttribute } from "react";
import { combatDataSlice, CombatDataState, useAppDispatch, useAppSelector } from "../../stores";
import cn from "./index.module.scss";

export interface CombatDataProps {
  combatData: CombatDataState;
  onChange: (e: React.ChangeEvent<HTMLInputElement>) => void;
}

export const CombatData: React.FC<CombatDataProps> = ({ combatData = {} as CombatDataState, onChange = () => {} }) => (
  <label className={cn.container}>
    <label>
      <span>Max Hit points:</span>
      <input name="maxHp" type="number" value={combatData.maxHp} onChange={onChange} />
    </label>

    <label>
      <span>Current HP:</span>
      <input name="currentHp" type="number" value={combatData.currentHp} onChange={onChange} />
    </label>

    <label>
      <span>Temp HP:</span>
      <input name="tempHp" type="number" value={combatData.tempHp} onChange={onChange} />
    </label>

    <label>
      <span>Hit Dices:</span>
      <input name="hitDices" value={combatData.hitDices} onChange={onChange} />
    </label>

    <label>
      <span>Speed:</span>
      <input name="speed" value={combatData.speed} onChange={onChange} />
    </label>

    <label>
      <span>Initiative:</span>
      <input name="initiative" type="number" value={combatData.initiative} onChange={onChange} />
    </label>
  </label>
);
