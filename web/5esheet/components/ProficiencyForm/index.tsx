import React, { useState } from "react";
import { Proficiency, Stat } from "../../stores";
import cn from "./index.module.scss";

export interface ProficiencyFormProps {
  stats: Stat[];
  onAdd: ({ name, profMultiplier, short }: Partial<Proficiency>) => void;
}

export const ProficiencyForm: React.FC<ProficiencyFormProps> = ({ stats = [], onAdd = () => {} }) => {
  const [name, setName] = useState("");
  const [profMultiplier, setProfMultiplier] = useState(0);
  const [short, setShort] = useState("none");

  const handleSubmit = (e: React.FormEvent<HTMLFormElement>) => {
    e.preventDefault();

    onAdd({ name, profMultiplier, short });

    setName("");
    setProfMultiplier(0);
    setShort("none");
  };

  const profLevelList = [
    { label: "No training", level: 0 },
    { label: "Half-training", level: 0.5 },
    { label: "Trained", level: 1 },
    { label: "Master", level: 2 },
  ];

  return (
    <form onSubmit={handleSubmit}>
      <label>
        <span>Name</span>
        <input value={name} onChange={(e) => setName(e.target.value)} />
      </label>

      <select name="stat" onChange={(e) => setShort(e.target.value)} value={short}>
        <option value="none">None</option>

        {stats.map((s) => (
          <option key={s.name} value={s.short}>
            {s.name}
          </option>
        ))}

        <option value="custom">Custom</option>
      </select>

      {short === "custom" ? (
        <label>
          <span>Influenced by stat: </span>
          <input value={short} onChange={(e) => setShort(e.target.value)} />
        </label>
      ) : null}

      {short !== "none" ? (
        <>
          {profLevelList.map((p) => (
            <label key={p.level}>
              <input
                type="radio"
                name="add_prof_level"
                checked={p.level === profMultiplier}
                onChange={() => setProfMultiplier(p.level)}
              />
              <span>{p.label}</span>
            </label>
          ))}
        </>
      ) : null}

      <button type="submit" disabled={name === ""}>
        Add Proficiency
      </button>
    </form>
  );
};
