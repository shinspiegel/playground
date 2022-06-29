import { calculateDamageFor, calculateHitFor } from "../../functions";
import { Stat, useAppSelector, Weapon } from "../../stores";
import cn from "./index.module.scss";

export interface WeaponTableProps {
  weapons: Weapon[];
  stats: Stat[];
  profBonus: number;
}

export const WeaponTable: React.FC<WeaponTableProps> = ({ profBonus = 0, stats = [], weapons = [] }) => (
  <table>
    <thead>
      <tr>
        <td>Name</td>
        <td>Hit</td>
        <td>Damage</td>
        <td>Range</td>
      </tr>
    </thead>

    <tbody>
      {weapons.map(({ damageDice, name, short, range, isProf }) => (
        <tr key={name}>
          <td>{name}</td>
          <td>
            [{short}] {calculateHitFor({ profBonus, short, stats, isProf })}
          </td>
          <td>{calculateDamageFor({ damageDice, short, stats })}</td>
          <td>{range}</td>
        </tr>
      ))}
    </tbody>
  </table>
);
