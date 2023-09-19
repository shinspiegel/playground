const GroceryList = require('../models/groceryList');
const decryptToken = require('../utils/decryptToken');
const handleError = require('../utils/handleError');
const { CodeError } = require('../utils/CodeError');
const getUserId = require('../utils/getUserID');

const index = async (req, res) => {
  try {
    const { userData } = decryptToken(await req.headers.authorization);
    const listOwner = getUserId(userData);
    const { year, week } = req.params;

    if (week && year) {
      const finded = await GroceryList.findOne({ listOwner, year, week })
        .populate('productsList.productReference')
        .catch((err) => {
          throw new CodeError({ message: err });
        });

      if (finded) {
        return res.json(finded);
      }

      return res.json({ week, year, productsList: [] });
    }

    if (year) {
      const finded = await GroceryList.find({ listOwner, year })
        .sort({ year: -1, week: -1 })
        .populate('productsList.productReference')
        .catch((err) => {
          throw new CodeError({ message: err });
        });
      return res.json(finded);
    }

    const finded = await GroceryList.find({ listOwner })
      .sort({ year: -1, week: -1 })
      .populate('productsList.productReference')
      .catch((err) => {
        throw new CodeError({ message: err });
      });
    return res.json(finded);
  } catch (err) {
    return handleError(err, res);
  }
};

const store = async (req, res) => {
  update(req, res);
};

const update = async (req, res) => {
  try {
    const { userData } = decryptToken(await req.headers.authorization);
    const listOwner = getUserId(userData);
    const { year, week } = req.params;
    const { productsList = [] } = req.body;

    const newList = await GroceryList.findOneAndUpdate(
      { listOwner, year, week },
      { $set: { productsList }, $inc: { __v: 1 } },
      { new: true, upsert: true },
    ).catch((err) => {
      throw new CodeError({ message: err });
    });

    const populatedList = await GroceryList.findById(newList._id)
      .populate('productsList.productReference')
      .catch((err) => {
        throw new CodeError({ message: err });
      });

    return res.json(populatedList);
  } catch (err) {
    return handleError(err, res);
  }
};

const destroy = async (req, res) => {
  try {
    const { userData } = decryptToken(await req.headers.authorization);
    const listOwner = getUserId(userData);
    const { year, week } = req.params;

    const deletedList = await GroceryList.findOneAndDelete({
      listOwner,
      year,
      week,
    }).catch((err) => {
      throw new CodeError({ message: err });
    });

    if (deletedList) deletedList.isDeleted = true;

    return res.json(deletedList);
  } catch (err) {
    return handleError(err, res);
  }
};

module.exports = { index, store, update, destroy };
