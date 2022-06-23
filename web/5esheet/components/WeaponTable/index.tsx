import { calculateDamageFor, calculateHitFor } from "../../functions";
import { useAppSelector } from "../../stores";
import cn from "./index.module.scss";

export const WeaponTable: React.FC = () => {
  const profBonus = useAppSelector((s) => s.info.proficiency);
  const weaponList = useAppSelector((s) => s.weapon.list);
  const stats = useAppSelector((s) => s.stats.list);

  return (
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
        {weaponList.map(({ damageDice, name, short, range, isProf }) => (
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
};
