import { Trait, useAppSelector } from "../stores";

export type UseTraitsList = {
  traits: Trait[];
};

export const useTraitsList = (): UseTraitsList => {
  const traits = useAppSelector((s) => s.traits.list);

  return {
    traits,
  };
};
