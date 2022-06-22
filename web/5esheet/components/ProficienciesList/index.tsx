import React, { useState } from "react";
import { addValueFromShortStat } from "../../functions";
import { Proficiency, Stat } from "../../stores";
import { ProficiencyForm } from "../ProficiencyForm";
import { ProficiencyItem } from "../ProficiencyItem";

import cn from "./index.module.scss";

export interface ProficienciesListProps {
  proficiencies: Proficiency[];
  profBonus: number;
  stats: Stat[];
  onAdd: ({ name, profMultiplier, short: stat }: Proficiency) => void;
  onRemove: (name: string) => void;
}

export const ProficienciesList: React.FC<ProficienciesListProps> = ({
  proficiencies = [],
  stats = [],
  profBonus = 0,
  onAdd = () => {},
  onRemove = () => {},
}) => {
  const orderedProfs = [...proficiencies].sort((a, b) => a.name.localeCompare(b.name));
  const list = addValueFromShortStat({ list: orderedProfs, stats, profBonus });

  return (
    <div className={cn.container}>
      <ProficiencyForm onAddProf={onAdd} stats={stats} />

      {list.map((p) => (
        <ProficiencyItem key={p.name} proficiency={p} onRemove={() => onRemove(p.name)} />
      ))}
    </div>
  );
};
