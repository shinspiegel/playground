import React from "react";
import { Stat } from "../../stores/slices/statsSlice";
import cn from "./index.module.scss";

export interface StatItemProps {
  stat: Stat;
  onValueChange: (e: React.ChangeEvent<HTMLInputElement>) => void;
  onModChange: (e: React.ChangeEvent<HTMLInputElement>) => void;
}

export const StatItem: React.FC<StatItemProps> = ({ stat = {}, onValueChange = () => {}, onModChange = () => {} }) => (
  <div className={cn.container}>
    <div>{stat.name}</div>

    <div>
      <input name={stat.name} type="number" value={stat.value} onChange={onValueChange} />
      <input name={stat.name} type="range" min="0" max="20" step="1" value={stat.value} onChange={onValueChange} />
    </div>

    <div>
      <input name={stat.name} type="number" value={stat.mod} onChange={onModChange} />
      <input name={stat.name} type="range" min="-5" max="5" step="1" value={stat.mod} onChange={onModChange} />
    </div>
  </div>
);
