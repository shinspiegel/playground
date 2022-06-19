import { SetStatSave, Stat } from "../../stores";
import { SaveItem } from "../SaveItem";
import cn from "./index.module.scss";

export type OnToggle = SetStatSave;

export interface SavesListProps {
  profBonus: number;
  list: Stat[];
  onToggle: ({ name, type, value }: OnToggle) => void;
}

export const SavesList: React.FC<SavesListProps> = ({
  list = [],
  profBonus = 0,
  onToggle = () => {},
}) => (
  <div className={cn.container}>
    {[...list]
      .sort((a, b) => a.weight - b.weight)
      .map((stat) => (
        <SaveItem
          key={stat.name}
          save={stat}
          profBonus={profBonus}
          onToggle={(e) =>
            onToggle({
              name: stat.name,
              type: "isProf",
              value: e.target.checked,
            })
          }
        />
      ))}
  </div>
);
