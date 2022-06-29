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
    if (e.target.name && e.target.valueAsNumber) {
      dispatch(
        changeValueFor({
          name: e.target.name,
          value: e.target.valueAsNumber,
        })
      );
    }
  };

  const onModChange: UseStatList["onValueChange"] = (e) => {
    if (e.target.name && e.target.valueAsNumber) {
      dispatch(
        changeModFor({
          name: e.target.name,
          value: e.target.valueAsNumber,
        })
      );
    }
  };

  return {
    stats,
    onValueChange,
    onModChange,
  };
};
