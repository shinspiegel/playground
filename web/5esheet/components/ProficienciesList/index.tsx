import React from "react";
import { ShortWithValue } from "../../functions";
import { Proficiency, Stat } from "../../stores";
import { ProficiencyForm } from "../ProficiencyForm";
import { ProficiencyItem } from "../ProficiencyItem";
import cn from "./index.module.scss";

export interface ProficienciesListProps {
  stats: Stat[];
  proficiencies: ShortWithValue<Proficiency>[];
  onRemove: (name: string) => void;
  onAdd: ({ name, profMultiplier, short }: Partial<Proficiency>) => void;
}

export const ProficienciesList: React.FC<ProficienciesListProps> = ({
  stats = [],
  proficiencies = [],
  onRemove = () => {},
  onAdd = () => {},
}) => (
  <div className={cn.container}>
    <ProficiencyForm stats={stats} onAdd={onAdd} />

    {proficiencies.map((prof) => (
      <ProficiencyItem key={prof.name} proficiency={prof} onRemove={() => onRemove(prof.name)} />
    ))}
  </div>
);
