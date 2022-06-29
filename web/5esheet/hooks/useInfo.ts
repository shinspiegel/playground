import { infoSlice, InfoSlice, useAppDispatch, useAppSelector } from "../stores";

export type UseInfo = {
  info: InfoSlice;
  onChange: (e: React.ChangeEvent<HTMLInputElement>) => void;
};

type OnChangeOpt = {
  property: keyof InfoSlice;
  value: string | number;
};

export const useInfo = (): UseInfo => {
  const dispatch = useAppDispatch();
  const info = useAppSelector((s) => s.info);

  const { setDndClass, setExperience, setLevel, setName, setPlayer, setRace } = infoSlice.actions;

  const onChange: UseInfo["onChange"] = (e) => {
    const name = e.target.name;

    if (name === "dndClass") dispatch(setDndClass(e.target.value));
    if (name === "name") dispatch(setName(e.target.value));
    if (name === "player") dispatch(setPlayer(e.target.value));
    if (name === "race") dispatch(setRace(e.target.value));
    if (name === "experience") dispatch(setExperience(e.target.valueAsNumber));
    if (name === "level") dispatch(setLevel(e.target.valueAsNumber));
  };

  return {
    info,
    onChange,
  };
};
