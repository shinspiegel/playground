import { Stat } from "../../stores";
import cn from "./index.module.scss";

export interface SaveItemProps {
  profBonus: number;
  save: Stat;
  onToggle: (e: React.ChangeEvent<HTMLInputElement>) => void;
}

export const SaveItem: React.FC<SaveItemProps> = ({ save = {}, profBonus = 0, onToggle = () => {} }) => {
  const mod = save?.mod ? save.mod : 0;
  const total = save.isProf ? mod + profBonus : mod;

  return (
    <label className={cn.container}>
      <div>{save.name}</div>
      <input name={save.name} type="checkbox" checked={save.isProf || false} onChange={onToggle} />
      <div>{total}</div>
    </label>
  );
};
