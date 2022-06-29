import { calculateDamageFor, calculateHitFor } from "../../functions";
import { Stat, useAppSelector, Weapon } from "../../stores";
import { WeaponForm } from "../WeaponForm";
import { WeaponTable } from "../WeaponTable";
import cn from "./index.module.scss";

export interface WeaponsListProps {
  weapons: Weapon[];
  stats: Stat[];
  profBonus: number;
  onAdd: (weapon: Weapon) => void;
}

export const WeaponList: React.FC<WeaponsListProps> = ({
  profBonus = 0,
  stats = [],
  weapons = [],
  onAdd = () => {},
}) => (
  <div className={cn.container}>
    <WeaponForm onAdd={onAdd} stats={stats} />
    <WeaponTable weapons={weapons} stats={stats} profBonus={profBonus} />
  </div>
);
