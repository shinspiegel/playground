import { Stat } from "../../stores";
import { SaveItem } from "../SaveItem";
import cn from "./index.module.scss";

export interface SavesListProps {
  saves: Stat[];
  profBonus: number;
  onChange: (e: React.ChangeEvent<HTMLInputElement>) => void;
}

export const SavesList: React.FC<SavesListProps> = ({ saves = [], profBonus = 0, onChange = () => {} }) => (
  <div className={cn.container}>
    {saves.map((stat) => (
      <SaveItem key={stat.name} save={stat} profBonus={profBonus} onToggle={onChange} />
    ))}
  </div>
);
