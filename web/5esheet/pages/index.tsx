import type { NextPage } from "next";
import {
  CombatData,
  Head,
  Info,
  ProficienciesList,
  ProficiencyBonus,
  SavesList,
  SkillList,
  StatList,
  TraitsList,
  WeaponList,
} from "../components";
import { ScrollableViewport } from "../components/ScrollableViewport";
import {
  useCombatData,
  useInfo,
  useProficienciesList,
  useProficiencyBonus,
  useSaveList,
  useSkillList,
  useStatList,
  useTraitsList,
  useWeaponsList,
} from "../hooks";
import styles from "./index.module.scss";

const Home: NextPage = () => {
  const { info, onChange: onInfoChange } = useInfo();
  const { onModChange, onValueChange, stats } = useStatList();
  const { bonus: profBonus, onChange: onProfChange } = useProficiencyBonus();
  const { saves, onChange: onSaveChange } = useSaveList();
  const { skills, onChange: onSkillChange } = useSkillList();
  const { proficiencies, onAdd: onProfAdd, onRemove: onProfRemove } = useProficienciesList();
  const { combatData, onChange: onCombatDataChange } = useCombatData();
  const { weapons, onAdd: onWeaponAdd } = useWeaponsList();
  const { traits } = useTraitsList();

  return (
    <>
      <Head />

      <main className={styles.container}>
        <div className={styles.info}>
          <Info info={info} onChange={onInfoChange} />
        </div>

        <div className={styles.stats}>
          <ScrollableViewport vertical>
            <StatList stats={stats} onValueChange={onValueChange} onModChange={onModChange} />
          </ScrollableViewport>
        </div>

        <div className={styles.profBonus}>
          <ProficiencyBonus bonus={profBonus} onChange={onProfChange} />
        </div>

        <div className={styles.saves}>
          <SavesList saves={saves} profBonus={profBonus} onChange={onSaveChange} />
        </div>

        <div className={styles.skills}>
          <ScrollableViewport vertical>
            <SkillList skills={skills} onChange={onSkillChange} />
          </ScrollableViewport>
        </div>

        <div className={styles.proficiencies}>
          <ProficienciesList stats={stats} proficiencies={proficiencies} onAdd={onProfAdd} onRemove={onProfRemove} />
        </div>

        <div className={styles.combat}>
          <CombatData combatData={combatData} onChange={onCombatDataChange} />
        </div>

        <div className={styles.weapons}>
          <WeaponList stats={stats} weapons={weapons} onAdd={onWeaponAdd} profBonus={profBonus} />
        </div>

        <div className={styles.traits}>
          <TraitsList traits={traits} />
        </div>
      </main>
    </>
  );
};

export default Home;
