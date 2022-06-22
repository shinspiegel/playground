import { addValueFromShortStat } from "../../functions";
import { skillsSlice, useAppDispatch, useAppSelector } from "../../stores";
import { SkillItem } from "../SkillItem";
import cn from "./index.module.scss";

export const SkillList: React.FC = () => {
  const dispatch = useAppDispatch();
  const profBonus = useAppSelector((s) => s.info.proficiency);
  const stats = useAppSelector((s) => s.stats.list);
  const skills = useAppSelector((s) => s.skills.list);
  const orderedSkills = [...skills].sort((a, b) =>
    a.name.localeCompare(b.name)
  );
  const list = addValueFromShortStat({ list: orderedSkills, stats, profBonus });
  const { changeSkillProf } = skillsSlice.actions;

  return (
    <div className={cn.container}>
      {list.map((skill) => (
        <SkillItem
          key={skill.name}
          skill={skill}
          onProfChange={({ name, value }) =>
            dispatch(changeSkillProf({ name, value }))
          }
        />
      ))}
    </div>
  );
};
