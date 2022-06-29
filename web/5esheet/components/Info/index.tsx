import { UserInfo } from "os";
import React from "react";
import { UseInfo } from "../../hooks";
import { InfoSlice } from "../../stores";
import cn from "./index.module.scss";

export interface InfoProps {
  info: InfoSlice;
  onChange: (e: React.ChangeEvent<HTMLInputElement>) => void;
}

export const Info: React.FC<InfoProps> = ({ info = {} as InfoSlice, onChange = () => {} }) => (
  <div className={cn.container}>
    <label>
      <span>Character Name</span>
      <input name="name" value={info.name} onChange={onChange} />
    </label>

    <label>
      <span>Class</span>
      <input name="dndClass" value={info.dndClass} onChange={onChange} />
    </label>

    <label>
      <span>Race</span>
      <input name="race" value={info.race} onChange={onChange} />
    </label>

    <label>
      <span>Player</span>
      <input name="player" value={info.player} onChange={onChange} />
    </label>

    <label>
      <span>Level</span>
      <input name="level" type="number" value={info.level} onChange={onChange} />
    </label>

    <label>
      <span>Experience</span>
      <input name="experience" type="number" value={info.experience} onChange={onChange} />
    </label>
  </div>
);
