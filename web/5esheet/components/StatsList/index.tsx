import { Stat, UpdateStateOpt } from "../../stores/slices/statsSlice";
import { StatItem } from "../StatItem";
import cn from "./index.module.scss";

export type OnStatUpdateOpt = UpdateStateOpt;

export interface StatListProps {
  list: Stat[];
  onStatUpdate: ({ name, type, value }: OnStatUpdateOpt) => void;
}

export const StatList: React.FC<StatListProps> = ({
  list = [],
  onStatUpdate = () => {},
}) => {
  return (
    <div data-area="stats" className={cn.container}>
      {[...list]
        .sort((a, b) => a.weight - b.weight)
        .map((stat) => (
          <StatItem
            key={stat.name}
            stat={stat}
            onValueChange={(e) =>
              onStatUpdate({
                name: stat.name,
                type: "value",
                value: Number(e.target.value),
              })
            }
            onModChange={(e) =>
              onStatUpdate({
                name: stat.name,
                type: "mod",
                value: Number(e.target.value),
              })
            }
          />
        ))}
    </div>
  );
};
