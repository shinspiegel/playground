import { Skill, Stat } from "../../stores";
import cn from "./index.module.scss";

export interface SkillItemProps {
  skill: Skill & { value: number };
  onProfChange: ({ name, value }: OnProfChange) => void;
}

type OnProfChange = { name: string; value: number };

export const SkillItem: React.FC<SkillItemProps> = ({
  skill = {} as SkillItemProps["skill"],
  onProfChange = () => {},
}) => {
  return (
    <div className={cn.container}>
      <div>
        [{skill.short}] {skill.name} - {skill.value}
      </div>

      <label>
        <input
          type="radio"
          name={`${skill.name}__prof_level`}
          checked={skill.profMultiplier === 0}
          onChange={() => onProfChange({ name: skill.name, value: 0 })}
        />
        <span>No Training</span>
      </label>

      <label>
        <input
          type="radio"
          name={`${skill.name}__prof_level`}
          checked={skill.profMultiplier === 0.5}
          onChange={() => onProfChange({ name: skill.name, value: 0.5 })}
        />
        <span>Half-Trained</span>
      </label>

      <label>
        <input
          type="radio"
          name={`${skill.name}__prof_level`}
          checked={skill.profMultiplier === 1}
          onChange={() => onProfChange({ name: skill.name, value: 1 })}
        />
        <span>Trained</span>
      </label>

      <label>
        <input
          type="radio"
          name={`${skill.name}__prof_level`}
          checked={skill.profMultiplier === 2}
          onChange={() => onProfChange({ name: skill.name, value: 2 })}
        />
        <span>Master</span>
      </label>
    </div>
  );
};
