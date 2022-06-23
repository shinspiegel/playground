import type { NextPage } from "next";
import { CombatData } from "../components/CombatData";
import { Head } from "../components/Head";
import { Info } from "../components/Info";
import { ProficienciesList } from "../components/ProficienciesList";
import { ProficiencyBonus } from "../components/Proficiency";
import { SavesList } from "../components/SavesList";
import { SkillList } from "../components/SkillsList";
import { StatList } from "../components/StatsList";
import { TraitsList } from "../components/TraitsList";
import { WeaponList } from "../components/WeaponList";
import styles from "./index.module.scss";

const Home: NextPage = () => (
  <>
    <Head />

    <main className={styles.container}>
      <div className={styles.info}>
        <Info />
      </div>

      <div className={styles.stats}>
        <StatList />
      </div>

      <div className={styles.profBonus}>
        <ProficiencyBonus />
      </div>

      <div className={styles.saves}>
        <SavesList />
      </div>

      <div className={styles.skills}>
        <SkillList />
      </div>

      <div className={styles.proficiencies}>
        <ProficienciesList />
      </div>

      <div className={styles.combat}>
        <CombatData />
      </div>

      <div className={styles.weapons}>
        <WeaponList />
      </div>

      <div className={styles.traits}>
        <TraitsList />
      </div>
    </main>
  </>
);

export default Home;
