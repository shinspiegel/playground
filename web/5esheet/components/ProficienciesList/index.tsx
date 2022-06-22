import React from "react";
import { addValueFromShortStat } from "../../functions";
import {
  proficienciesSlice,
  Proficiency,
  Stat,
  useAppDispatch,
  useAppSelector,
} from "../../stores";
import { ProficiencyForm } from "../ProficiencyForm";
import { ProficiencyItem } from "../ProficiencyItem";
import cn from "./index.module.scss";

export const ProficienciesList: React.FC = () => {
  const dispatch = useAppDispatch();
  const stats = useAppSelector((s) => s.stats.list);
  const profBonus = useAppSelector((s) => s.info.proficiency);
  const profs = useAppSelector((s) => s.proficiencies.list);
  const orderedProfs = [...profs].sort((a, b) => a.name.localeCompare(b.name));
  const list = addValueFromShortStat({ list: orderedProfs, stats, profBonus });
  const { removeProfByName } = proficienciesSlice.actions;

  return (
    <div className={cn.container}>
      <ProficiencyForm />

      {list.map((p) => (
        <ProficiencyItem
          key={p.name}
          proficiency={p}
          onRemove={() => dispatch(removeProfByName(p.name))}
        />
      ))}
    </div>
  );
};
