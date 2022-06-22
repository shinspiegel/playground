import type { NextPage } from "next";
import { CombatData } from "../components/CombatData";
import { Head } from "../components/Head";
import { Info } from "../components/Info";
import { ProficienciesList } from "../components/ProficienciesList";
import { ProficiencyBonus } from "../components/Proficiency";
import { SavesList } from "../components/SavesList";
import { SkillList } from "../components/SkillsList";
import { StatList } from "../components/StatsList";
import styles from "./index.module.scss";

const Home: NextPage = () => (
  <>
    <Head />

    <main>
      <Info />
      <hr />
      <StatList />
      <hr />
      <ProficiencyBonus />
      <hr />
      <SavesList />
      <hr />
      <SkillList />
      <hr />
      <ProficienciesList />
      <hr />
      <CombatData />
      <hr />
      <div>Weapons</div>
      <div>Traits</div>
    </main>
  </>
);

export default Home;
