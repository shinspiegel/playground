import React from "react";
import { addValueFromShortStat, ShortWithValue } from "../functions";
import { Skill, skillsSlice, useAppDispatch, useAppSelector } from "../stores";

export type UseSkillList = {
  skills: ShortWithValue<Skill>[];
  onChange: ({ name, value }: { name: string; value: number }) => void;
};

export const useSkillList = (): UseSkillList => {
  const dispatch = useAppDispatch();
  const profBonus = useAppSelector((s) => s.info.proficiency);
  const stats = useAppSelector((s) => s.stats.list);
  const list = useAppSelector((s) => s.skills.list);
  const orderedSkills = [...list].sort((a, b) => a.name.localeCompare(b.name));

  const skills = addValueFromShortStat({
    list: orderedSkills,
    stats,
    profBonus,
  });

  const { changeSkillProf } = skillsSlice.actions;

  const onChange: UseSkillList["onChange"] = ({ name, value }) => {
    dispatch(changeSkillProf({ name, value }));
  };

  return {
    skills,
    onChange,
  };
};
