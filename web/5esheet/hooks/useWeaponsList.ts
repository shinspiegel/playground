import { useAppDispatch, useAppSelector, Weapon, weaponSlice } from "../stores";

export type UseWeaponsList = {
  weapons: Weapon[];
  onAdd: (weapon: Weapon) => void;
};

export const useWeaponsList = (): UseWeaponsList => {
  const dispatch = useAppDispatch();
  const weapons = useAppSelector((s) => s.weapon.list);
  const { add } = weaponSlice.actions;

  const onAdd: UseWeaponsList["onAdd"] = (weapon) => {
    dispatch(add(weapon));
  };

  return {
    weapons,
    onAdd,
  };
};
