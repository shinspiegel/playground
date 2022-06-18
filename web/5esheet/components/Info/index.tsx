import React from "react";
import { InfoSlice, UpdateTextFromOps } from "../../stores";
import cn from "./index.module.scss";

type OnInfoChangeOpt = UpdateTextFromOps;

export interface InfoProps {
  info: InfoSlice;
  onTextChange: ({ property, value }: OnInfoChangeOpt) => void;
  onLevelChange: (level: number) => void;
  onExperienceChange: (experience: number) => void;
}

export const Info: React.FC<InfoProps> = ({
  info = {},
  onTextChange = () => {},
  onLevelChange = () => {},
  onExperienceChange = () => {},
}) => (
  <div className={cn.container}>
    <div>
      <label>
        <span>Character Name</span>
        <input
          value={info.name}
          onChange={(e) =>
            onTextChange({ property: "name", value: e.target.value })
          }
        />
      </label>
    </div>

    <div>
      <label>
        <span>Race</span>
        <input
          value={info.race}
          onChange={(e) =>
            onTextChange({ property: "race", value: e.target.value })
          }
        />
      </label>
    </div>

    <div>
      <label>
        <span>Class</span>
        <input
          value={info.class}
          onChange={(e) =>
            onTextChange({ property: "class", value: e.target.value })
          }
        />
      </label>
    </div>

    <div>
      <label>
        <span>Level</span>
        <input
          type="number"
          value={info.level}
          onChange={(e) => onLevelChange(Number(e.target.value))}
        />
      </label>
    </div>

    <div>
      <label>
        <span>Experience</span>
        <input
          type="number"
          step="25"
          value={info.experience}
          onChange={(e) => onExperienceChange(Number(e.target.value))}
        />
      </label>
    </div>
  </div>
);
