import { addValueFromShortStat, ShortWithValue } from "../functions/addValueFromShortStat";
import { proficienciesSlice, Proficiency, useAppDispatch, useAppSelector } from "../stores";

export type UseProficienciesList = {
  proficiencies: ShortWithValue<Proficiency>[];
  onRemove: (name: string) => void;
  onAdd: ({ name, profMultiplier, short }: Partial<{ name: string; profMultiplier: number; short: string }>) => void;
};

export const useProficienciesList = (): UseProficienciesList => {
  const dispatch = useAppDispatch();

  const stats = useAppSelector((s) => s.stats.list);
  const profBonus = useAppSelector((s) => s.info.proficiency);
  const profs = useAppSelector((s) => s.proficiencies.list);
  const orderedProfs = [...profs].sort((a, b) => a.name.localeCompare(b.name));

  const { addProf, removeProfByName } = proficienciesSlice.actions;

  const proficiencies = addValueFromShortStat({
    list: orderedProfs,
    stats,
    profBonus,
  });

  const onRemove = (name: string) => {
    dispatch(removeProfByName(name));
  };

  const onAdd: UseProficienciesList["onAdd"] = ({ name, profMultiplier, short }) => {
    if (!name || name === "") {
      return;
    }

    const hasStat = short !== "none";

    if (hasStat) {
      dispatch(addProf({ name, profMultiplier, short }));
    } else {
      dispatch(addProf({ name }));
    }
  };

  return {
    proficiencies,
    onRemove,
    onAdd,
  };
};
