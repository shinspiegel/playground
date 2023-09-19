const getRandomNumber = () => {
  const number = Math.floor(Math.random() * 10);
  if (number >= 10) return getRandomNumber();
  return number.toFixed(0);
};

const getRandomFourDigits = () => {
  const randomNumber = [];

  while (randomNumber.length < 4) {
    randomNumber.unshift(getRandomNumber());
  }

  return randomNumber.join('');
};

module.exports = { getRandomNumber, getRandomFourDigits };
