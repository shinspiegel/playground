import { statsSlice, useAppDispatch, useAppSelector } from "../../stores";
import { SaveItem } from "../SaveItem";
import cn from "./index.module.scss";

export const SavesList: React.FC = () => {
  const dispatch = useAppDispatch();
  const list = useAppSelector((s) => s.stats.list);
  const profBonus = useAppSelector((s) => s.info.proficiency);
  const orderedList = [...list].sort((a, b) => a.weight - b.weight);
  const { setSaveProficiencyFor } = statsSlice.actions;

  return (
    <div className={cn.container}>
      {orderedList.map((stat) => (
        <SaveItem
          key={stat.name}
          save={stat}
          profBonus={profBonus}
          onToggle={(e) =>
            dispatch(
              setSaveProficiencyFor({
                name: stat.name,
                value: e.target.checked,
              })
            )
          }
        />
      ))}
    </div>
  );
};
