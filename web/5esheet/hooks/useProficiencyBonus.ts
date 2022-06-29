import { infoSlice, useAppDispatch, useAppSelector } from "../stores";

export type UseProficiencyBonus = {
  bonus: number;
  onChange: (e: React.ChangeEvent<HTMLInputElement>) => void;
};

export const useProficiencyBonus = (): UseProficiencyBonus => {
  const dispatch = useAppDispatch();
  const bonus = useAppSelector((s) => s.info.proficiency);
  const { setProficiency } = infoSlice.actions;

  const onChange: UseProficiencyBonus["onChange"] = (e) => {
    dispatch(setProficiency(e.target.valueAsNumber));
  };

  return {
    bonus,
    onChange,
  };
};
