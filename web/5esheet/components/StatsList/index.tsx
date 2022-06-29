import React from "react";
import { UseStatList } from "../../hooks/useStatList";
import { useAppDispatch, useAppSelector } from "../../stores";
import { Stat, statsSlice } from "../../stores/slices/statsSlice";
import { StatItem } from "../StatItem";
import cn from "./index.module.scss";

export interface StatList {
  stats: Stat[];
  onValueChange: (e: React.ChangeEvent<HTMLInputElement>) => void;
  onModChange: (e: React.ChangeEvent<HTMLInputElement>) => void;
}

export const StatList: React.FC<StatList> = ({ stats = [], onValueChange = () => {}, onModChange = () => {} }) => (
  <div className={cn.container}>
    {stats.map((stat) => (
      <StatItem key={stat.name} stat={stat} onValueChange={onValueChange} onModChange={onModChange} />
    ))}
  </div>
);
