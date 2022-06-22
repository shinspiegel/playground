import React, { useState } from "react";
import { Proficiency, Stat } from "../../stores";
import cn from "./index.module.scss";

export interface ProficiencyFormProps {
  stats: Stat[];
  onAddProf: ({ name, profMultiplier, short: stat }: Proficiency) => void;
}

export const ProficiencyForm: React.FC<ProficiencyFormProps> = ({ onAddProf = () => {}, stats = [] as Stat[] }) => {
  const [name, setName] = useState("");
  const [profMultiplier, setProfMultiplier] = useState(0);
  const [stat, setStat] = useState("none");

  const handleSubmit = (e: React.FormEvent<HTMLFormElement>) => {
    e.preventDefault();

    if (!name || name === "") {
      return;
    }

    const hasStat = stat !== "none";

    if (hasStat) {
      onAddProf({ name, profMultiplier, short: stat });
    } else {
      onAddProf({ name });
    }

    setName("");
    setProfMultiplier(0);
    setStat("none");
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

      <select name="stat" onChange={(e) => setStat(e.target.value)} value={stat}>
        <option value="none">None</option>

        {stats.map((s) => (
          <option key={s.name} value={s.short}>
            {s.name}
          </option>
        ))}

        <option value="custom">Custom</option>
      </select>

      {stat === "custom" ? (
        <label>
          <span>Influenced by stat: </span>
          <input value={stat} onChange={(e) => setStat(e.target.value)} />
        </label>
      ) : null}

      {stat !== "none" ? (
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
