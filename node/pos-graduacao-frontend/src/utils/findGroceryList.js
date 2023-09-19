/**
 * This functions receives a array of groceryLists and returns the filtered one by year and week.
 * @param {Object[]} groceryList This is the grocery list to find
 * @param {String|Number} year This is the year to filter
 * @param {String|Number} week This is the week to filter
 */
const findGroceryList = (groceryList, year, week) => {
  return groceryList.filter((list) => {
    return list.week == week && list.year == year;
  })[0];
};

export default findGroceryList;
