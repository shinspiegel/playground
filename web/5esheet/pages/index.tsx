import type { NextPage } from "next";
import { Head } from "../components/Head";
import { StatList, StatListProps } from "../components/StatsList";
import { updateState, useAppDispatch, useAppSelector } from "../stores";
import styles from "./index.module.scss";

const Home: NextPage = () => {
  const dispatch = useAppDispatch();
  const stats = useAppSelector((s) => s.stats.list);
  const onStatUpdate: StatListProps["onStatUpdate"] = (opt) =>
    dispatch(updateState(opt));

  return (
    <>
      <Head />

      <main>
        <StatList list={stats} onStatUpdate={onStatUpdate} />

        <hr />

        <div>Info</div>
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
