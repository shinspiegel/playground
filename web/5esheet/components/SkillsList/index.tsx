import React from "react";
import { addValueFromShortStat, ShortWithValue } from "../../functions";
import { ChangeSkillProf, Skill, skillsSlice, useAppDispatch, useAppSelector } from "../../stores";
import { SkillItem } from "../SkillItem";
import cn from "./index.module.scss";

export interface SkillListProps {
  skills: ShortWithValue<Skill>[];
  onChange: ({ name, value }: ChangeSkillProf) => void;
}

export const SkillList: React.FC<SkillListProps> = ({ skills = [], onChange = () => {} }) => (
  <div className={cn.container}>
    {skills.map((skill) => (
      <SkillItem key={skill.name} skill={skill} onChange={onChange} />
    ))}
  </div>
);
