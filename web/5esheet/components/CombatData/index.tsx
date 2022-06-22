import { CombatDataState, Stat } from "../../stores";
import cn from "./index.module.scss";

export interface CombatDataProps {
  combatData: CombatDataState;
}

export const CombatData: React.FC<CombatDataProps> = ({ combatData = {} as CombatDataState }) => (
  <label className={cn.container}>
    <div>Max Hit points: {combatData.maxHitPoints}</div>
    <div>Current Hit points: {combatData.currentHitPoints}</div>
    <div>Temporary Hit points: {combatData.temporaryHitPoints}</div>
    <div>Hit dices: {combatData.hitDices}</div>
    <div>Speed: {combatData.speed}</div>
    <div>Initiative: {combatData.initiative}</div>
    <div>Death Saving</div>
  </label>
);
