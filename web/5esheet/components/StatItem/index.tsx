import React from "react";
import { Stat } from "../../stores/slices/statsSlice";
import cn from "./index.module.scss";

export interface StatItemProps {
  stat: Stat;
  onValueChange: (e: React.ChangeEvent<HTMLInputElement>) => void;
  onModChange: (e: React.ChangeEvent<HTMLInputElement>) => void;
}

export const StatItem: React.FC<StatItemProps> = ({
  stat = {},
  onValueChange = () => {},
  onModChange = () => {},
}) => (
  <div className={cn.container}>
    <div>{stat.name}</div>
    <input value={stat.value} onChange={onValueChange} />
    <input value={stat.mod} onChange={onModChange} />
  </div>
);
