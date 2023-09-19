/**
 * This function will return the week number on the year. If no argument is given, it uses now as default.
 * @param {Date} originalDate This is the date to get the week number. Default is now.
 * @returns {Number} This is the weeknumber
 */
const getWeekNumber = (originalDate = new Date()) => {
  const firstDayOnThisYear = new Date(originalDate.getFullYear(), 0, 1);

  const timeBetween = originalDate.getTime() - firstDayOnThisYear.getTime();
  const timeInOneYear = 86400000;
  const firstDay = firstDayOnThisYear.getDay();

  const weekNumber = Math.ceil((timeBetween / timeInOneYear + firstDay) / 7);

  return weekNumber;
};

export default getWeekNumber;
