import React from "react";
import { Stat } from "../../stores/slices/statsSlice";
import cn from "./index.module.scss";

export interface StatItemProps {
  stat: Stat;
  onValueChange: (e: React.ChangeEvent<HTMLInputElement>) => void;
  onModChange: (e: React.ChangeEvent<HTMLInputElement>) => void;
}

export const StatItem: React.FC<StatItemProps> = ({
  stat = {} as Stat,
  onValueChange = () => {},
  onModChange = () => {},
}) => (
  <div className={cn.container}>
    <div className={cn.title}>{stat.name}</div>

    <div className={cn.stat}>
      <input
        className={cn.statInput}
        name={stat.name}
        min="0"
        step="1"
        type="number"
        value={stat.value}
        onChange={onValueChange}
      />
    </div>

    <div className={cn.mod}>
      <input className={cn.modInput} name={stat.name} type="number" value={stat.mod} onChange={onModChange} />
    </div>
  </div>
);
