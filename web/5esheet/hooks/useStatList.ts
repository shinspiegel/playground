import { Stat, statsSlice, useAppDispatch, useAppSelector } from "../stores";

export type UseStatList = {
  stats: Stat[];
  onValueChange: (e: React.ChangeEvent<HTMLInputElement>) => void;
  onModChange: (e: React.ChangeEvent<HTMLInputElement>) => void;
};

export const useStatList = (): UseStatList => {
  const dispatch = useAppDispatch();
  const list = useAppSelector((s) => s.stats.list);
  const stats = [...list].sort((a, b) => a.weight - b.weight);
  const { changeModFor, changeValueFor } = statsSlice.actions;

  const onValueChange: UseStatList["onValueChange"] = (e) => {
    const value = e.target.valueAsNumber || 0;
    const name = e.target.name;

    if (name) {
      dispatch(changeValueFor({ name, value }));
    }
  };

  const onModChange: UseStatList["onValueChange"] = (e) => {
    const value = e.target.valueAsNumber || 0;
    const name = e.target.name;

    if (name) {
      dispatch(changeModFor({ name, value }));
    }
  };

  return {
    stats,
    onValueChange,
    onModChange,
  };
};
