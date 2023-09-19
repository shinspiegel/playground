import React from 'react';
import './index.scss';

/**
 *
 * @param {Object} props
 * @param {Object[]} props.statsList
 * @param {String} props.statsList.title
 * @param {String} props.statsList.subTitle
 * @param {String} props.statsList.value
 */
const QuickStats = ({ statsList }) => {
  return (
    <section className="quickStats">
      <ul className="quickStats__list">
        {statsList.map((c, i) => (
          <QuickStatItem key={c.title + i} label={c.title} value={c.value} />
        ))}
      </ul>
    </section>
  );
};

const QuickStatItem = ({ label, value }) => (
  <li className="quickStats__item">
    <span className="quickStats__value">{value}</span>
    <h2 className="quickStats__label">{label}</h2>
  </li>
);

export default QuickStats;
