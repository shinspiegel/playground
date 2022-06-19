import { Skill, Stat } from "../../stores";
import cn from "./index.module.scss";

export interface SkillItemProps {
  skill: Skill;
}

export const SkillItem: React.FC<SkillItemProps> = ({ skill = {} }) => {
  return (
    <div className={cn.container}>
      <label>{skill.name}</label>
    </div>
  );
};
