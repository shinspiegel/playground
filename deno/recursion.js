function flatten(inputArray) {
  const outputArray = [];

  inputArray.forEach((item) => {
    if (Array.isArray(item)) {
      outputArray.push(...flatten(item));
    } else {
      outputArray.push(item);
    }
  });

  return outputArray;
}

console.log(flatten([0, [1], 2, 3, [4, 5, 6, [7, 8, 9]]]));
