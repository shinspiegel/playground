import { useAppDispatch, useAppSelector } from "../../stores";
import { statsSlice } from "../../stores/slices/statsSlice";
import { StatItem } from "../StatItem";
import cn from "./index.module.scss";

export const StatList: React.FC = ({}) => {
  const dispatch = useAppDispatch();
  const list = useAppSelector((s) => s.stats.list);
  const orderedList = [...list].sort((a, b) => a.weight - b.weight);
  const { changeModFor, changeValueFor } = statsSlice.actions;

  return (
    <div className={cn.container}>
      {orderedList.map((stat) => (
        <StatItem
          key={stat.name}
          stat={stat}
          onValueChange={(e) =>
            dispatch(
              changeValueFor({
                name: stat.name,
                value: e.target.valueAsNumber,
              })
            )
          }
          onModChange={(e) =>
            dispatch(
              changeModFor({
                name: stat.name,
                value: e.target.valueAsNumber,
              })
            )
          }
        />
      ))}
    </div>
  );
};
