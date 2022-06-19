import { Stat } from "../../stores";
import cn from "./index.module.scss";

export interface SaveItemProps {
  profBonus: number;
  save: Stat;
  onToggle: (e: React.ChangeEvent<HTMLInputElement>) => void;
}

export const SaveItem: React.FC<SaveItemProps> = ({
  save = {},
  profBonus = 0,
  onToggle = () => {},
}) => (
  <label className={cn.container}>
    <div>{save.name}</div>
    <input type="checkbox" checked={save.isProf || false} onChange={onToggle} />
    <div>{save.isProf ? save.mod + profBonus : save.mod}</div>
  </label>
);
