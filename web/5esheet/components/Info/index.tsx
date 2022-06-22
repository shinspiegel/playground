import React from "react";
import { infoSlice, useAppDispatch, useAppSelector } from "../../stores";
import cn from "./index.module.scss";

export const Info: React.FC = () => {
  const dispatch = useAppDispatch();
  const { dndClass, experience, level, name, player, race } = useAppSelector(
    (s) => s.info
  );
  const { setDndClass, setExperience, setLevel, setName, setPlayer, setRace } =
    infoSlice.actions;

  return (
    <div className={cn.container}>
      <label>
        <span>Character Name</span>
        <input
          value={name}
          onChange={(e) => dispatch(setName(e.target.value))}
        />
      </label>

      <label>
        <span>Class</span>
        <input
          value={dndClass}
          onChange={(e) => dispatch(setDndClass(e.target.value))}
        />
      </label>

      <label>
        <span>Race</span>
        <input
          value={race}
          onChange={(e) => dispatch(setRace(e.target.value))}
        />
      </label>

      <label>
        <span>Player</span>
        <input
          value={player}
          onChange={(e) => dispatch(setPlayer(e.target.value))}
        />
      </label>

      <label>
        <span>Level</span>
        <input
          type="number"
          value={level}
          onChange={(e) => dispatch(setLevel(e.target.valueAsNumber))}
        />
      </label>

      <label>
        <span>Experience</span>
        <input
          type="number"
          value={experience}
          onChange={(e) => dispatch(setExperience(e.target.valueAsNumber))}
        />
      </label>
    </div>
  );
};
