const brain = require('brain.js');
const GroceryList = require('../models/groceryList');

const suggestion = async (listOwner, rate) => {
  let foundList = await GroceryList.find({ listOwner })
    .sort({ year: -1, week: -1 })
    .limit(10)
    .catch((err) => {
      throw new Error(err);
    });

  foundList.reverse();

  const trainingData = getTrainingData(foundList);

  const runDataQuery = {
    week: foundList[foundList.length - 1].week,
    ...getProducts(foundList[foundList.length - 1].productsList),
  };

  const neuralNetwork = new brain.NeuralNetwork();
  neuralNetwork.train(trainingData);
  const output = neuralNetwork.run(runDataQuery);

  const resultArray = getProductsByRate(output, rate);

  return resultArray;
};

const getProductsByRate = (neuralOutput, rate) => {
  const result = Object.entries(neuralOutput).map((item) => {
    if (item[1] >= rate) {
      return {
        isBought: false,
        productName: item[0],
        productReference: null,
      };
    }
  });

  return result.filter((n) => n);
};

const getTrainingData = (groceryList) => {
  let trainingData = [];

  for (let i = 0; i < groceryList.length - 1; i++) {
    const currentWeek = groceryList[i];
    const nextWeek = groceryList[i + 1];

    const result = {
      input: {
        week: currentWeek.week,
        ...getProducts(currentWeek.productsList),
      },
      output: {
        ...getProducts(nextWeek.productsList),
      },
    };

    trainingData.push(result);
  }

  return trainingData;
};

const getProducts = (arrayList) => {
  let result = {};

  arrayList.map((item) => (result[item.productName.toLowerCase()] = 1));

  return result;
};

module.exports = suggestion;
