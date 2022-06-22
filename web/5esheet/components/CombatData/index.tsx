import { combatDataSlice, useAppDispatch, useAppSelector } from "../../stores";
import cn from "./index.module.scss";

export const CombatData: React.FC = () => {
  const {
    currentHitPoints,
    hitDices,
    initiative,
    maxHitPoints,
    speed,
    temporaryHitPoints,
  } = useAppSelector((s) => s.combatData);
  const dispatch = useAppDispatch();
  const {
    setCurrentHitPoints,
    setHitDices,
    setInitiative,
    setMaxHitPoints,
    setSpeed,
    setTemporaryHitPoints,
  } = combatDataSlice.actions;

  return (
    <label className={cn.container}>
      <label>
        <span>Max Hit points:</span>
        <input
          type="number"
          value={maxHitPoints}
          onChange={(e) => dispatch(setMaxHitPoints(e.target.valueAsNumber))}
        />
      </label>

      <label>
        <span>Current HP:</span>
        <input
          type="number"
          value={currentHitPoints}
          onChange={(e) =>
            dispatch(setCurrentHitPoints(e.target.valueAsNumber))
          }
        />
      </label>

      <label>
        <span>Temp HP:</span>
        <input
          type="number"
          value={temporaryHitPoints}
          onChange={(e) =>
            dispatch(setTemporaryHitPoints(e.target.valueAsNumber))
          }
        />
      </label>

      <label>
        <span>Hit Dices:</span>
        <input
          value={hitDices}
          onChange={(e) => dispatch(setHitDices(e.target.value))}
        />
      </label>

      <label>
        <span>Speed:</span>
        <input
          value={speed}
          onChange={(e) => dispatch(setSpeed(e.target.value))}
        />
      </label>

      <label>
        <span>Initiative:</span>
        <input
          type="number"
          value={initiative}
          onChange={(e) => dispatch(setInitiative(e.target.valueAsNumber))}
        />
      </label>
    </label>
  );
};
