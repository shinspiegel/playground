import { Skill, skillsSlice, Stat } from "../../stores";
import { SkillItem } from "../SkillItem";
import cn from "./index.module.scss";

export interface SkillListProps {
  profBonus: number;
  skills: Skill[];
  stats: Stat[];
  onProfChange: ({ name, value }: OnProfChange) => void;
}

type OnProfChange = { name: string; value: number };

type SkillProps = Skill & {
  value: number;
};

export const SkillList: React.FC<SkillListProps> = ({
  skills = [],
  stats = [],
  profBonus = 0,
  onProfChange = () => {},
}) => {
  const list: SkillProps[] = [...skills]
    .sort((a, b) => a.name.localeCompare(b.name))
    .map((sk) => {
      const stat = stats.find((s) => s.short === sk.short);
      const mod = stat?.mod || 0;
      const value = sk.profMultiplier * profBonus + mod;

      return { ...sk, value };
    });

  return (
    <div className={cn.container}>
      {list.map((s) => (
        <div key={s.name}>
          <div>
            [{s.short}] {s.name} - {s.value}
          </div>

          <label>
            <input
              type="radio"
              name={`${s.name}__prof_level`}
              checked={s.profMultiplier === 0}
              onChange={() => onProfChange({ name: s.name, value: 0 })}
            />
            <span>No Training</span>
          </label>

          <label>
            <input
              type="radio"
              name={`${s.name}__prof_level`}
              checked={s.profMultiplier === 0.5}
              onChange={() => onProfChange({ name: s.name, value: 0.5 })}
            />
            <span>Half-Trained</span>
          </label>

          <label>
            <input
              type="radio"
              name={`${s.name}__prof_level`}
              checked={s.profMultiplier === 1}
              onChange={() => onProfChange({ name: s.name, value: 1 })}
            />
            <span>Trained</span>
          </label>

          <label>
            <input
              type="radio"
              name={`${s.name}__prof_level`}
              checked={s.profMultiplier === 2}
              onChange={() => onProfChange({ name: s.name, value: 2 })}
            />
            <span>Master</span>
          </label>
        </div>
      ))}
    </div>
  );
};
