import { Trait, useAppSelector } from "../../stores";

export interface TraitsListProps {
  traits: Trait[];
}

export const TraitsList: React.FC<TraitsListProps> = ({ traits = [] }) => (
  <div>
    {traits.map((t) => (
      <div key={t.name}>{t.name}</div>
    ))}
  </div>
);
