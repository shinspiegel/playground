import { getWeekNumber } from './index';

/**
 * This function will receive a changeWeek number that will increase or decrease the week number, and return a new year and a new week.
 * @param {Object} config
 * @param {Number} config.weekChange This is the change value that will increase or decrease the week number by one. A positive number will increase a negative number will decrease.
 * @param {Number} config.year This is the current year
 * @param {Number} config.week This is the current week
 */
const changeWeek = ({ weekChange, year, week }) => {
  if (weekChange > 1) weekChange = 1;
  if (weekChange < -1) weekChange = -1;

  let newYear = Number(year);
  let newWeek = Number(week) + Number(weekChange);

  if (newWeek <= 0) {
    newYear -= 1;
    newWeek = getWeekNumber(new Date(`${newYear}/12/31`));

    return { year: newYear, week: newWeek };
  }

  if (newWeek >= getWeekNumber(new Date(`${newYear}/12/31`))) {
    newYear += 1;
    newWeek = 1;

    return { year: newYear, week: newWeek };
  }

  return { year: newYear, week: newWeek };
};

export default changeWeek;
