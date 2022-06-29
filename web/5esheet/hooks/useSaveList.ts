import { Stat, statsSlice, useAppDispatch, useAppSelector } from "../stores";

export type UseSaveList = {
  saves: Stat[];
  onChange: (e: React.ChangeEvent<HTMLInputElement>) => void;
};

export const useSaveList = (): UseSaveList => {
  const dispatch = useAppDispatch();
  const list = useAppSelector((s) => s.stats.list);
  const saves = [...list].sort((a, b) => a.weight - b.weight);
  const { setSaveProficiencyFor } = statsSlice.actions;

  const onChange: UseSaveList["onChange"] = (e) => {
    dispatch(
      setSaveProficiencyFor({
        name: e.target.name,
        value: e.target.checked,
      })
    );
  };

  return {
    saves,
    onChange,
  };
};
