import type { NextPage } from "next";
import { Head } from "../components/Head";
import { Info, InfoProps } from "../components/Info";
import { ProficiencyBonus } from "../components/Proficiency";
import { SavesList, SavesListProps } from "../components/SavesList";
import { SkillList, SkillListProps } from "../components/SkillsList";
import { StatList, StatListProps } from "../components/StatsList";
import {
  updateStatValue,
  useAppDispatch,
  useAppSelector,
  updateTextFrom,
  updateExperience,
  updateLevel,
  updateProf,
  setStatSave,
  changeSkillProf,
} from "../stores";
import styles from "./index.module.scss";

type OnTextChange = InfoProps["onTextChange"];
type OnExpChange = InfoProps["onExperienceChange"];
type OnLevelChange = InfoProps["onLevelChange"];
type OnStatUpdate = StatListProps["onStatUpdate"];
type OnProfBonusChange = (prof: number) => void;
type OnToggleSaveProf = SavesListProps["onToggle"];
type OnProfSkillChange = SkillListProps["onProfChange"];

const Home: NextPage = () => {
  const dispatch = useAppDispatch();

  const info = useAppSelector((s) => s.info);
  const onTextChange: OnTextChange = (opt) => dispatch(updateTextFrom(opt));
  const onExpChange: OnExpChange = (exp) => dispatch(updateExperience(exp));
  const onLevelChange: OnLevelChange = (lvl) => dispatch(updateLevel(lvl));

  const stats = useAppSelector((s) => s.stats.list);
  const onStatUpdate: OnStatUpdate = (opt) => dispatch(updateStatValue(opt));

  const OnProfBonusChange: OnProfBonusChange = (prof) =>
    dispatch(updateProf(prof));

  const onToggle: OnToggleSaveProf = (opt) => dispatch(setStatSave(opt));

  const skills = useAppSelector((s) => s.skills.list);
  const onProfSkillChange: OnProfSkillChange = (opt) =>
    dispatch(changeSkillProf(opt));

  return (
    <>
      <Head />

      <main>
        <Info
          info={info}
          onTextChange={onTextChange}
          onLevelChange={onLevelChange}
          onExperienceChange={onExpChange}
        />

        <hr />

        <StatList list={stats} onStatUpdate={onStatUpdate} />

        <hr />

        <ProficiencyBonus
          proficiency={info.proficiency}
          onProfChange={OnProfBonusChange}
        />

        <hr />

        <SavesList
          list={stats}
          profBonus={info.proficiency}
          onToggle={onToggle}
        />

        <hr />

        <SkillList
          skills={skills}
          stats={stats}
          profBonus={info.proficiency}
          onProfChange={onProfSkillChange}
        />

        <hr />

        <div>Proficiencies</div>
        <div>Combat</div>
        <div>Weapons</div>
        <div>Traits</div>
      </main>
    </>
  );
};

export default Home;
