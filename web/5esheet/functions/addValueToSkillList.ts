import { SkillItemProps } from "../components/SkillItem";
import { Skill, Stat } from "../stores";

export type AddValueToSkillListOpt = {
  skills: Skill[];
  stats: Stat[];
  profBonus: number;
};

export type AddValueToSkillList = SkillItemProps["skill"][];

export function addValueToSkillList({
  skills = [],
  stats = [],
  profBonus = 0,
}: AddValueToSkillListOpt): AddValueToSkillList {
  const list: AddValueToSkillList = [...skills].map((sk) => {
    const stat = stats.find((s) => s.short === sk.short);
    const mod = stat?.mod || 0;
    const value = sk.profMultiplier * profBonus + mod;

    return { ...sk, value };
  });

  return list;
}
