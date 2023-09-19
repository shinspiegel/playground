const GroceryList = require('../models/groceryList');
const getUserId = require('../utils/getUserID');
const decryptToken = require('../utils/decryptToken');
const { CodeError, errorList } = require('../utils/CodeError');
const handleError = require('../utils/handleError');

const index = async (req, res) => {
  try {
    const { userData } = decryptToken(await req.headers.authorization);
    const listOwner = getUserId(userData);
    const { year, week } = req.params;
    const lastWeek = week - 1;

    const lastWeekFound = await GroceryList.findOne({ listOwner, year, week: lastWeek })
      .populate('productsList.productReference')
      .catch((err) => {
        throw new CodeError({ message: err });
      });

    let lastWeekItems = [];

    if (lastWeekFound) {
      lastWeekItems = lastWeekFound.productsList.filter((item) => item.isBought === false);
    }

    return res.json(lastWeekItems);
  } catch (err) {
    return handleError(err, res);
  }
};

const store = async (req, res) => {
  try {
    const { userData } = decryptToken(await req.headers.authorization);
    const listOwner = getUserId(userData);
    const { year, week } = req.params;
    const lastWeek = week - 1;

    const lastWeekFound = await GroceryList.findOne({ listOwner, year, week: lastWeek })
      .populate('productsList.productReference')
      .catch((err) => {
        throw new CodeError({ message: err });
      });

    let lastWeekItems = [];

    if (lastWeekFound && lastWeekFound.productsList) {
      lastWeekItems = lastWeekFound.productsList.filter((item) => item.isBought === false);
      lastWeekFound.productsList = lastWeekFound.productsList.filter(
        (item) => item.isBought === true,
      );
      lastWeekFound.save();
    }

    const found = await GroceryList.findOne({ listOwner, year, week })
      .populate('productsList.productReference')
      .catch((err) => {
        throw new CodeError({ message: err });
      });

    if (found) {
      found.productsList = [...found.productsList, ...lastWeekItems];
      found.save();
    }

    return res.json(found);
  } catch (err) {
    return handleError(err, res);
  }
};

const update = async (req, res) => {
  return handleError(new CodeError(errorList.notImplemented), res);
};

const destroy = async (req, res) => {
  return handleError(new CodeError(errorList.notImplemented), res);
};

module.exports = { index, store, update, destroy };
