import { SkillItemProps } from "../components/SkillItem";
import { Skill, Stat } from "../stores";

export type AddValueFromShortStatOpt<T extends { short?: string; profMultiplier?: number }> = {
  list: T[];
  stats: Stat[];
  profBonus: number;
};

export type ShortWithValue<T extends { short?: string; profMultiplier?: number }> = T & { value: number };

export function addValueFromShortStat<T extends { short?: string; profMultiplier?: number }>({
  list = [],
  stats = [],
  profBonus = 0,
}: AddValueFromShortStatOpt<T>): ShortWithValue<T>[] {
  const listWithValue: ShortWithValue<T>[] = [...list].map((sk) => {
    const stat = stats.find((s) => s.short === sk.short);
    const modifier = stat?.mod || 0;
    const multiplier = sk.profMultiplier ? sk.profMultiplier : 0;

    const value = multiplier * profBonus + modifier;

    return { ...sk, value };
  });

  return listWithValue;
}
