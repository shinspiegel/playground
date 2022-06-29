import { useState } from "react";
import { Stat, useAppDispatch, useAppSelector, Weapon, weaponSlice, WeaponState } from "../../stores";
import cn from "./index.module.scss";

export interface WeaponFormProps {
  onAdd: (weapon: Weapon) => void;
  stats: Stat[];
}

export const WeaponForm: React.FC<WeaponFormProps> = ({ onAdd = () => {}, stats = [] }) => {
  const [name, setName] = useState("Name");
  const [damageDice, setDamageDice] = useState("1d6");
  const [short, setShort] = useState("STR");
  const [isProf, setIsProf] = useState(true);
  const [range, setRange] = useState<string>("Melee");
  const [bonus, setBonus] = useState<Weapon["bonus"]>();

  const handleSubmit = (e: React.FormEvent<HTMLFormElement>) => {
    e.preventDefault();

    onAdd({ name, damageDice, short, bonus, isProf, range });

    setName("");
    setDamageDice("1d6");
    setShort("STR");
    setIsProf(true);
    setRange("Melee");
    setBonus(undefined);
  };

  return (
    <form className={cn.container} onSubmit={handleSubmit}>
      <label>
        <span>Name</span>
        <input value={name} onChange={(e) => setName(e.target.value)} />
      </label>

      <label>
        <span>Damage Dice</span>
        <input value={damageDice} onChange={(e) => setDamageDice(e.target.value)} />
      </label>

      <label>
        <span>Stat</span>

        <select value={short} onChange={(e) => setShort(e.target.value)}>
          <option value="NONE">Select Modifier</option>
          {stats.map((s) => (
            <option key={s.name} value={s.short}>
              {s.name}
            </option>
          ))}
          <option value="">Custom</option>
        </select>

        {![...stats.map((s) => s.short), "NONE"].includes(short) ? (
          <label>
            <span>Short</span>
            <input value={short} onChange={(e) => setShort(e.target.value)} />
          </label>
        ) : null}
      </label>

      <label>
        <span>Range</span>
        <input value={range} onChange={(e) => setRange(e.target.value)} />
      </label>

      <label>
        <span>Is Proficient</span>
        <input type="checkbox" checked={isProf} onChange={(e) => setIsProf(e.target.checked)} />
      </label>

      <label>
        <span>Extra Bonus to Hit</span>
        <input type="number" value={bonus?.hit} onChange={(e) => setBonus({ ...bonus, hit: e.target.valueAsNumber })} />
      </label>

      <label>
        <span>Extra Bonus to Damage</span>
        <input
          type="number"
          value={bonus?.damage}
          onChange={(e) => setBonus({ ...bonus, damage: e.target.valueAsNumber })}
        />
      </label>

      <button type="submit">Add</button>
    </form>
  );
};
