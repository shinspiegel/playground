import { useAppSelector } from "../../stores";

export const TraitsList: React.FC = () => {
  const traits = useAppSelector((s) => s.traits.list);

  return (
    <div>
      {traits.map((t) => (
        <div key={t.name}>{t.name}</div>
      ))}
    </div>
  );
};
