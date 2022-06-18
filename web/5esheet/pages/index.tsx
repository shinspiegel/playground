import type { NextPage } from "next";
import { Head } from "../components/Head";
import { Info, InfoProps } from "../components/Info";
import { StatList, StatListProps } from "../components/StatsList";
import {
  updateState,
  useAppDispatch,
  useAppSelector,
  updateTextFrom,
  updateExperience,
  updateLevel,
} from "../stores";
import styles from "./index.module.scss";

const Home: NextPage = () => {
  const dispatch = useAppDispatch();

  const info = useAppSelector((s) => s.info);
  const onTextChange: InfoProps["onTextChange"] = (opt) =>
    dispatch(updateTextFrom(opt));
  const onExperienceChange: InfoProps["onExperienceChange"] = (exp) =>
    dispatch(updateExperience(exp));
  const onLevelChange: InfoProps["onLevelChange"] = (lvl) =>
    dispatch(updateLevel(lvl));

  const stats = useAppSelector((s) => s.stats.list);
  const onStatUpdate: StatListProps["onStatUpdate"] = (opt) =>
    dispatch(updateState(opt));

  return (
    <>
      <Head />

      <main>
        <Info
          info={info}
          onTextChange={onTextChange}
          onLevelChange={onLevelChange}
          onExperienceChange={onExperienceChange}
        />

        <hr />

        <StatList list={stats} onStatUpdate={onStatUpdate} />

        <hr />

        <div>Proficiency Bonus</div>
        <div>Saves</div>
        <div>Skills</div>
        <div>Proficiencies</div>
        <div>Combat</div>
        <div>Weapons</div>
        <div>Traits</div>
      </main>
    </>
  );
};

export default Home;
