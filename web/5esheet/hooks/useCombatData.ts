import React from "react";
import { combatDataSlice, CombatDataState, useAppDispatch, useAppSelector } from "../stores";

export type UseCombatData = {
  combatData: CombatDataState;
  onChange: (e: React.ChangeEvent<HTMLInputElement>) => void;
};

export const useCombatData = (): UseCombatData => {
  const combatData = useAppSelector((s) => s.combatData);
  const dispatch = useAppDispatch();
  const { setCurrentHp, setHitDices, setInitiative, setMaxHp, setSpeed, setTempHp } = combatDataSlice.actions;

  const onChange: UseCombatData["onChange"] = (e) => {
    const name = e.target.name;

    if (e.target.type === "number") {
      if (name === "maxHitPoints") dispatch(setMaxHp(e.target.valueAsNumber));
      if (name === "currentHitPoints") dispatch(setCurrentHp(e.target.valueAsNumber));
      if (name === "initiative") dispatch(setInitiative(e.target.valueAsNumber));
      if (name === "temporaryHitPoints") dispatch(setTempHp(e.target.valueAsNumber));
    }

    if (name === "hitDices") dispatch(setHitDices(e.target.value));
    if (name === "speed") dispatch(setSpeed(e.target.value));
  };

  return {
    combatData,
    onChange,
  };
};
