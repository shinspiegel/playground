import { addValueFromShortStat } from "../../functions";
import { Skill, skillsSlice, Stat } from "../../stores";
import { SkillItem, SkillItemProps } from "../SkillItem";
import cn from "./index.module.scss";

export interface SkillListProps {
  profBonus: number;
  skills: Skill[];
  stats: Stat[];
  onProfChange: SkillItemProps["onProfChange"];
}

export const SkillList: React.FC<SkillListProps> = ({
  skills = [],
  stats = [],
  profBonus = 0,
  onProfChange = () => {},
}) => {
  const orderedSkills = [...skills].sort((a, b) => a.name.localeCompare(b.name));
  const list = addValueFromShortStat({ list: orderedSkills, stats, profBonus });

  return (
    <div className={cn.container}>
      {list.map((skill) => (
        <SkillItem key={skill.name} skill={skill} onProfChange={onProfChange} />
      ))}
    </div>
  );
};
