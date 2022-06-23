import { calculateDamageFor, calculateHitFor } from "../../functions";
import { useAppSelector } from "../../stores";
import { WeaponForm } from "../WeaponForm";
import { WeaponTable } from "../WeaponTable";
import cn from "./index.module.scss";

export const WeaponList: React.FC = () => {
  const profBonus = useAppSelector((s) => s.info.proficiency);
  const weaponList = useAppSelector((s) => s.weapon.list);
  const stats = useAppSelector((s) => s.stats.list);

  return (
    <div className={cn.container}>
      <WeaponForm />
      <WeaponTable />
    </div>
  );
};
